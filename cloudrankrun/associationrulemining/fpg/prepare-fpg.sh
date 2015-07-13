#!/bin/bash

source ../../configuration/config.include
source file.include

fpg_file=
if   [ $1 = low  ]
then
    fpg_file="fpg-accidents.dat"
    ratio="low"
elif [ $1 = mid  ]
then
    fpg_file="fpg-retail.dat"
    ratio="mid"
elif [ $1 = high ]
then
    fpg_file="fpg-webdocs.dat"
    ratio="high"
elif test -z $1
then
    echo "Workload wasnt specified, run the low workload as default."
    fpg_file="fpg-accidents.dat"
    ratio="low"
else
    echo "Workload specified doesnot exist, please doublecheck."
    exit
fi

#${HADOOP_HOME}/bin/hadoop fs -rmr "${hdfsdata_dir}/fpg*"
${HADOOP_HOME}/bin/hadoop fs -put "${basedata_dir}/${fpg_file}" ${hdfsdata_dir}/

sed -i "/$ratio/d" ./file.include
sed -i "/$ratio/d" ../../configuration/file_all.include
echo "fpg_file=${fpg_file}-$ratio"                        >> ./file.include
echo "fpg_file=${fpg_file}-$ratio"                       >> ../../configuration/file_all.include
