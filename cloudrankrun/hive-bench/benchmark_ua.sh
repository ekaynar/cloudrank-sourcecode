#!/usr/bin/env bash

# set up configurations
BASE_DIR=$HIVE_HOME/hivebench
LOG_DIR="$HADOOP_HOME/cloudrankrun/hive-bench/hivelogs"
TIME_CMD="/usr/bin/time -f Time:%e"
NUM_OF_TRIALS=1
LOG_FILE=$LOG_DIR/uservisits_aggre.log
TIMING_FILE=$LOG_DIR/uservisits_aggre.csv
HADOOP_CMD="$HADOOP_HOME/bin/hadoop"
HIVE_CMD="$HIVE_HOME/bin/hive"
query="uservisits_aggre.hive" 

# set up the execution log file
if [ -e "$LOG_FILE" ]; then
	timestamp=`date "+%F-%R" --reference=$LOG_FILE`
	backupFile="$LOG_FILE.$timestamp"
	mv $LOG_FILE $backupFile
fi

# set up the timing log file
if [ -e "$TIMING_FILE" ]; then
	timestamp=`date "+%F-%R" --reference=$TIMING_FILE`
	backupFile="$TIMING_FILE.$timestamp"
	mv $TIMING_FILE $backupFile
fi

# output the timing headers
echo 'Timings, grep select, rankings select, uservisits aggregation, uservisits-rankings join' >> $TIMING_FILE

trial=0
while [ $trial -lt $NUM_OF_TRIALS ]; do
	trial=`expr $trial + 1`
	echo "Executing Trial #$trial of $NUM_OF_TRIALS trial(s)..."
   	echo "Trial $trial" >> $TIMING_FILE
    
	# Hive queries
	echo -n "Hive," >> $TIMING_FILE
		echo "Running Hive query: $query" | tee -a $LOG_FILE
		timemsg=$($TIME_CMD $HIVE_CMD -f $BASE_DIR/$query 2>&1 | tee -a $LOG_FILE | grep '^Time:')
		echo $timemsg
		echo -n "${timemsg:5}," >> $TIMING_FILE 
    echo  " " >> $TIMING_FILE	
	
done # TRIAL

