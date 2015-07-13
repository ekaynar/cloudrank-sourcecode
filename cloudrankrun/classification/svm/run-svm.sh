#!/bin/bash

source ../../configuration/config.include
source ./file.include
let "size=0"
base_size=`du -h ${basedata_dir}/svm-data | cut -f 1`
unit=`echo $base_size | sed 's/[0-9.]//g'`
base_size=`echo $base_size | sed 's/[A-Z]//g'`

if test -z $1
then
    size=$base_size
else
    size=$(echo "$1*$base_size" | bc)
fi

svm_file=svm-$size$unit
${HADOOP_HOME}/bin/hadoop fs -rmr /cloudrank-out/${svm_file}-out
sh svm-hadoop.sh   /cloudrank-data/${svm_file}   /cloudrank-out/${svm_file}-out
