#!/bin/bash
source ../../configuration/config.include
dataset=`echo $1 | tr [a-z] [A-Z]`
${HADOOP_HOME}/bin/hadoop fs -rmr /cloudrank-out/rtw-sort-$dataset-out
${HADOOP_HOME}/bin/hadoop jar  ../../jars/${hadoop_examples_jar}  sort -Dmapred.reduce.tasks=2 /cloudrank-data/rtw-sort-$dataset /cloudrank-out/rtw-sort-$dataset-out
