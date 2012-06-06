# Wrapper to launch Vowpal Wabbit on BigDataR Linux

hadoop jar $HADOOP_HOME/contrib/streaming/hadoop-*streaming*.jar -Dmapred.job.map.memory.mb=512 -input $1 -output $2 -file /usr/local/bin/vw -file /home/play/runvwbd.sh -mapper 'runvwbd.sh' -reducer NONE