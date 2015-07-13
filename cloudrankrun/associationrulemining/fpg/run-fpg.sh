#!/bin/bash

source ../../configuration/config.include
source file.include

fpg_file=
if   [ $1 = "low" ] 
then
    fpg_file="fpg-accidents.dat"
elif [ $1 = "mid" ] 
then
    fpg_file="fpg-retail.dat"
elif [ $1 = "high" ]
then
    fpg_file="fpg-webdocs.dat"
elif test -z $1
then
    echo "Workload wasnt specified, run the low workload as default."
    fpg_file="fpg-accidents.dat"
else
    echo "Workload specified doesnot exist, please doublecheck."
    exit
fi
${HADOOP_HOME}/bin/hadoop fs -rmr /cloudrank-out/${fpg_file}-out
${MAHOUT_HOME}/bin/mahout fpg -i /cloudrank-data/${fpg_file} -o /cloudrank-out/${fpg_file}-out -s 4 -k 100 -method mapreduce
