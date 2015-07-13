#!/bin/bash
#-jobconf mapred.job.queue.name=default \
source ../../configuration/config.include
${HADOOP_HOME}/bin/hadoop jar ../../jars/${hadoop_streaming_jar} \
-input $1 \
-output $2 \
-mapper predict_main \
-file simple_svm \
-jobconf mapred.reduce.tasks=0 \
-jobconf mapred.skip.mode.enabled=true \
-jobconf mapred.skip.map.max.skip.records=1 \
-jobconf mapred.skip.attempts.to.start.skipping=2 
