#!/bin/bash

source ../../configuration/config.include
source ./file.include

let "size=0"
base_size=`du -h ${basedata_dir}/hmm-data | cut -f 1`
unit=`echo $base_size | sed 's/[0-9]//g' | sed 's/\.//g'`
base_size=`echo $base_size | sed 's/[A-Z]*//g'`




# create hmm data and upload into hdfs
if test -z $1
then
    echo "No rate input, copy original data as new dataset, with size of $base_size$unit"
    cat "${basedata_dir}/hmm-data" > "${tempdata_dir}/hmm-$base_size$unit"
    size=$base_size
    ratio=1
else
    size=$(echo "$1*$base_size" | bc)
    echo "Rate $1 specified, new dataset with size $size$unit is creating."
    cat "${basedata_dir}/hmm-data" > "${tempdata_dir}/hmm-$size$unit"
    ratio=$1
    let "i=1"
    while [ $i -lt $1 ]
    do
       let "i=$i+1"
       cat "${basedata_dir}/hmm-data" >> "${tempdata_dir}/hmm-$size$unit"
    done
fi

${HADOOP_HOME}/bin/hadoop fs -put "${tempdata_dir}/hmm-$size$unit" ${hdfsdata_dir}/
rm -f "${tempdata_dir}/hmm-$size$unit"

sed -i "/$size$unit/d" .file.include
sed -i "/$size$unit/d" ../../configuration/file_all.include
echo "hmm_file=hmm-$size$unit-$ratio"               >>  ./file.include
echo "hmm_file=hmm-$size$unit-$ratio"               >>  ../../configuration/file_all.include
