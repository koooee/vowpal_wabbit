# Wrapper to launch Vowpal Wabbit on BigDataR Linux
spanning_tree
hadoop jar $HADOOP_HOME/contrib/streaming/hadoop-*streaming*.jar \
-Dmapred.job.map.memory.mb=2500 \
-Dmapred.task.timeout=120000 \
-input $1 \
-output $2 \
-file /usr/local/bin/vw \
-file ./runvwbd.sh \
-mapper 'runvw.sh' \
-reducer NONE