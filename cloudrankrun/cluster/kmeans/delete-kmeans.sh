#!/bin/bash

source ../../configuration/config.include
source file.include

kmeans_file=
if   [ $1 = low  ]
then
    kmeans_file="sougou-low-tfidf-vec"
elif [ $1 = mid  ]
then
    kmeans_file="sougou-mid-tfidf-vec"
elif [ $1 = high ]
then
    kmeans_file="sougou-high-tfidf-vec"
elif test -z $1
then
    echo "Workload wasnt specified, please specify one"
    exit
fi
${HADOOP_HOME}/bin/hadoop fs -rmr "${hdfsdata_dir}/${kmeans_file}"
sed -i "/$1/d" ./file.include
sed -i "/$1/d" ../../configuration/file.include
