#!/bin/bash

source ../../configuration/config.include

unit=`echo $1 | sed 's/[0-9.]//g' | tr [a-z] [A-Z]`
size=`echo $1 | sed 's/[A-Za-z]//g'`

${HADOOP_HOME}/bin/hadoop fs -rmr /cloudrank-data/rtw-wordcount-$size$unit

sed -i "/$size$unit/d" ./file.include
sed -i "/$size$unit/d" ../../configuration/file_all.include
