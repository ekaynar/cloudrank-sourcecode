#/bin/bash
source ../../configuration/config.include
let "size=0"
base_size=`du -h ${basedata_dir}/hmm-data | cut -f 1`
unit=`echo $base_size | sed 's/[0-9]//g' | sed 's/\.//g'`
base_size=`echo $base_size | sed 's/[A-Z]*//g'`
if test -z $1
then
    size=$base_size
else
    size=$(echo "$1*$base_size" | bc)
fi
hmm_file=hmm-$size$unit



${HADOOP_HOME}/bin/hadoop fs -rmr /cloudrank-out/${hmm_file}-out
sh hmm-hadoop.sh   /cloudrank-data/${hmm_file}   /cloudrank-out/${hmm_file}-out
