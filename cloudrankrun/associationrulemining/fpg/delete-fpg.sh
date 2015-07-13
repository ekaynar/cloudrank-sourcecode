#/bin/bash

source ../../configuration/config.include
source file.include

fpg_file=
if   [ $1 = low  ]
then
    fpg_file="fpg-accidents.dat"
elif [ $1 = mid  ]
then
    fpg_file="fpg-retail.dat"
elif [ $1 = high ]
then
    fpg_file="fpg-webdocs.dat"
elif test -z $1
then
    echo "Workload specified doesnot exist, please specify one."
    exit
fi

${HADOOP_HOME}/bin/hadoop fs -rmr "${hdfsdata_dir}/${fpg_file}"

sed -i "/$1/d" ./file.include
sed -i "/$1/d" ../../configuration/file_all.include
