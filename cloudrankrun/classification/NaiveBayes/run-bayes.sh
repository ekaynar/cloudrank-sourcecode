#!/bin/bash

source ../../configuration/config.include
source file.include
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

bayes_file=bayes-$size$unit
${HADOOP_HOME}/bin/hadoop fs -rmr /cloudrank-out/${bayes_file}-model
${MAHOUT_HOME}/bin/mahout trainclassifier -i /cloudrank-data/${bayes_file} -o /cloudrank-out/${bayes_file}-model  -mf 100 -ms 10
