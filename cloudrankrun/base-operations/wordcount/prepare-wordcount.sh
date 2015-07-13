#!/bin/bash

source ../../configuration/config.include

# generate parameters
unit=`echo $1 | sed 's/[0-9.]//g' | tr [a-z] [A-Z]`
size=`echo $1 | sed 's/[A-Za-z]//g'`
bytes_per_map=0
maps_per_host=0
unit_size=0
hosts=`/liuwb/hadoop-1.0.2/bin/hadoop dfsadmin -report | grep -Po "Datanodes available: \d+" | grep -Po "\d+"`

if   [ "$unit" = "M" ]; then
    unit_size=20
elif [ "$unit" = "G" ]; then
    unit_size=30
elif [ "$unit" = "T" ]; then
    unit_size=40
elif test -z $1; then
    echo "Workload wasnt specified, please specify one(for example:1m/1g/1t)"
    exit
fi

size_per_host=`echo "scale=2; $size / $hosts" | bc`

index=0
while [ $(echo "$size_per_host < 0.5 " | bc) -eq 1 -o $(echo "$size_per_host > 1.5" | bc) -eq 1 ]
do
    if [ $(echo "$size_per_host < 0.5 " | bc) -eq 1 ]
    then
        size_per_host=`echo "scale=2; $size_per_host * 2" | bc`
        let "index-=1"
    else
        size_per_host=`echo "scale=2; $size_per_host / 2" | bc`
        let "index+=1"
    fi
done
let "unit_size+=$index"

if   [ $unit_size -gt 33 ]
then
    let "maps_per_host=8*2**($unit_size-33)"
    let "bytes_per_host=2**$unit_size";
    bytes_per_map=`echo "($bytes_per_host*$size_per_host)/$maps_per_host"| bc`
elif [ $unit_size -gt 29 ]
then
    maps_per_host=8
    let "bytes_per_host=2**$unit_size"; 
    bytes_per_map=`echo "($bytes_per_host*$size_per_host)/$maps_per_host"| bc`
else
    maps_per_host=1
    let "bytes_per_host=2**$unit_size";
    bytes_per_map=`echo "($bytes_per_host*$size_per_host)"| bc`
fi
bytes_per_map=${bytes_per_map%.*}

echo BYTES_PER_MAP $bytes_per_map
echo MAPS_PER_HOST $maps_per_host
echo HOSTS $hosts


# fix the config file
lineno=`grep -n "bytes_per_map" config-wordcount.xml`
lineno=${lineno%:*}
let "lineno+=1"
sed -i "$lineno s/<value>[0-9]*<\/value>/<value>$bytes_per_map<\/value>/" config-wordcount.xml

lineno=`grep -n "maps_per_host" config-wordcount.xml`
lineno=${lineno%:*}
let "lineno+=1"
sed -i "$lineno s/<value>[0-9]*<\/value>/<value>$maps_per_host<\/value>/" config-wordcount.xml


echo "generating rtw-wordcount-$size$unit data"
#${HADOOP_HOME}/bin/hadoop fs -rmr /cloudrank-data/rtw-wordcount-$size$unit
${HADOOP_HOME}/bin/hadoop jar ../../jars/${hadoop_examples_jar}  randomtextwriter -conf config-wordcount.xml  /cloudrank-data/rtw-wordcount-$size$unit
sed -i "/$size$unit/d" ./file.include
sed -i "/$size$unit/d" ../../configuration/file_all.include
echo "wordcount_file=rtw-wordcount-$size$unit-$1"     >>./file.include
echo "wordcount_file=rtw-wordcount-$size$unit-$1"     >>../../configuration/file_all.include
