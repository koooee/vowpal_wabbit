# TODO: how do we wrap an interface around this?
# FIXME: We are using a random number that isn't really a unique ID
#vw -b 24 --total 4 --node 4 --unique_id $RANDOM --cache_file temp.cache --spanserver master0 -f vwmodel --passes 1 --adaptive --exact_adaptive_norm -d /dev/stdin --regularization=1 --loss_function=logistic

mapper=`printenv mapred_task_id | cut -d "_" -f 5`
echo "mapper: $mapper" > /dev/stderr
rm -f temp.cache
echo 'Starting training' > /dev/stderr
echo $1 > /dev/stderr
mapred_job_id=`echo $mapred_job_id | tr -d 'job_'`
echo "mapred_job_id: $mapred_job_id" > /dev/stderr
echo "mapred_map_tasks: $mapred_map_tasks" > /dev/stderr
echo "mapreduce_job_submithost: $mapreduce_job_submithost" > /dev/stderr
echo "Data Sample:" > /dev/stderr
(head -n 4 /dev/stdin) > /dev/stderr
./vw \
-d /dev/stdin \
-b 18 \
--total $mapred_map_tasks \
--node $(hostname | grep -o [0-9]*) \
--unique_id $mapred_job_id \
--span_server master0 \
-q ui \
--rank 10 \
--l2 0.001 \
--learning_rate 0.025 \
--passes 20 \
--decay_learning_rate 0.97 \
--power_t 0 \
-f movielens.reg \
--cache_file movielens.cache

