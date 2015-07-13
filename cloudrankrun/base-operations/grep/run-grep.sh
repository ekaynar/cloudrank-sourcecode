#!/bin/bash
source ../../configuration/config.include
dataset=`echo $1 | tr [a-z] [A-Z]`

${HADOOP_HOME}/bin/hadoop fs -rmr /cloudrank-out/rtw-grep-$dataset-out
${HADOOP_HOME}/bin/hadoop jar ../../jars/${hadoop_examples_jar} grep  /cloudrank-data/rtw-grep-$dataset /cloudrank-out/rtw-grep-$dataset-out a*xyz
