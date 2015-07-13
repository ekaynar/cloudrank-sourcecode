#!/bin/bash

source ../../configuration/config.include
source ./file.include

let "size=0"
base_size=`du -h ${basedata_dir}/wikipediainput | cut -f 1`
unit=`echo $base_size | sed 's/[0-9.]//g'`
base_size=`echo $base_size | sed 's/[A-Z]//g'`

if test -z $1
then
    size=$base_size
else
    size=$(echo "$1*$base_size" | bc)
fi

${HADOOP_HOME}/bin/hadoop fs -rmr "${hdfsdata_dir}/bayes-$size$unit"

sed -i "/$size$unit/d" ./file.include
sed -i "/$size$unit/d" ../../configuration/file_all.include
