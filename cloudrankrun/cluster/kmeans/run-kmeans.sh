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
    echo "Workload wasnt specified, run the low workload as default."
    kmeans_file="sougou-low-tfidf-vec"
else
    echo "Workload specified doesnot exist, please doublecheck."
    exit
fi

${HADOOP_HOME}/bin/hadoop fs -rmr /cloudrank-out/${kmeans_file}
${MAHOUT_HOME}/bin/mahout kmeans -i /cloudrank-data/${kmeans_file} -o /cloudrank-out/${kmeans_file}  -k 5 -c /cloudrank-out/${kmeans_file} -x 5

