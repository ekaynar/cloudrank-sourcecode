#!bin/bash
${HADOOP_HOME}/bin/hadoop fs -mkdir /data/rankings/
${HADOOP_HOME}/bin/hadoop fs -mkdir /data/uservisits/
${HADOOP_HOME}/bin/hadoop fs -put "${basedata_dir}/Rankings01.dat" /data/rankings/
${HADOOP_HOME}/bin/hadoop fs -put "${basedata_dir}/UserVisits01.dat" /data/uservisits/
