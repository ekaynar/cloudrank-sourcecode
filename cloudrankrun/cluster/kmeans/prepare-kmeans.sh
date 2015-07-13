#!/bin/bash

source ../../configuration/config.include
source file.include

if   [ $1 = low  ]
then
    kmeans_file="sougou-low-tfidf-vec"
    ratio="low"
elif [ $1 = mid  ]
then
    kmeans_file="sougou-mid-tfidf-vec"
    ratio="mid"
elif [ $1 = high ]
then
    kmeans_file="sougou-high-tfidf-vec"
    ratio="high"
elif test -z $1
then
    echo "Workload wasnt specified, run the low workload as default."
    kmeans_file="sougou-low-tfidf-vec"
    ratio="low"
else
    echo "Workload specified doesnot exist, please doublecheck."
    exit
fi
#${HADOOP_HOME}/bin/hadoop fs -rmr "${hdfsdata_dir}/kmeans*"
${HADOOP_HOME}/bin/hadoop fs -copyFromLocal  "${basedata_dir}/${kmeans_file}" ${hdfsdata_dir}/
sed -i "/$ratio/d" ./file.include
sed -i "/$ratio/d" ../../configuration/file.include
echo "kmeans_file=$kmeans_file-$ratio"                   >>  ./file.include
echo "kmeans_file=$kmeans_file-$ratio"                  >> ../../configuration/file_all.include

