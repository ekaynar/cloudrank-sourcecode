#!/bin/bash
source ../../configuration/config.include
source file.include
let "size=0"
base_size=`du -h ${basedata_dir}/ibcf-data | cut -f 1`
unit=`echo $base_size | sed 's/[0-9.]//g'`
base_size=`echo $base_size | sed 's/[A-Z]//g'`

if test -z $1
then
    size=$base_size
else
    size=$(echo "$1*$base_size" | bc)
fi

ibcf_file=ibcf-$size$unit
${HADOOP_HOME}/bin/hadoop fs -rmr /cloudrank-out/${ibcf_file}-out
${HADOOP_HOME}/bin/hadoop fs -rmr /cloudrank-out/${ibcf_file}-temp
${MAHOUT_HOME}/bin/mahout recommenditembased  --input /cloudrank-data/${ibcf_file} --output /cloudrank-out/${ibcf_file}-out  --numRecommendations 3  -s SIMILARITY_EUCLIDEAN_DISTANCE --tempDir /cloudrank-out/${ibcf_file}-temp
