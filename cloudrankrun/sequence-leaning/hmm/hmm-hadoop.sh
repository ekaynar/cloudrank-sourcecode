#!/bin/bash
source ../../configuration/config.include
${HADOOP_HOME}/bin/hadoop jar  ${basejars_dir}/${hadoop_streaming_jar} \
-input $1 \
-output $2 \
-mapper preprocess \
-file simple_ictclas \
-jobconf mapred.reduce.tasks=1 \
-jobconf mapred.skip.mode.enabled=true   \
-jobconf mapred.skip.map.max.skip.records=5 \
-jobconf mapred.skip.attempts.to.start.skipping=2     
