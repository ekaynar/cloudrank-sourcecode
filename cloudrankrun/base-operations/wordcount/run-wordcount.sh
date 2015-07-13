#!/bin/bash
source ../../configuration/config.include

dataset=`echo $1 | tr [a-z] [A-Z]`
${HADOOP_HOME}/bin/hadoop fs -rmr /cloudrank-out/rtw-wordcount-$dataset-out
${HADOOP_HOME}/bin/hadoop jar  ../../jars/${hadoop_examples_jar}  wordcount  /cloudrank-data/rtw-wordcount-$dataset /cloudrank-out/rtw-wordcount-$dataset-out
