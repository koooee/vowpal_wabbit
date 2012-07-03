#!/bin/bash
mapper=`printenv mapred_task_id | cut -d "_" -f 5`
echo $mapper > /dev/stderr
rm -f temp.cache
echo 'Starting training' > /dev/stderr
mapred_job_id=`echo $mapred_job_id | tr -d 'job_'`
echo "mapred_map_tasks: $mapred_map_tasks" > /dev/stderr
echo "mapper: $mapper" > /dev/stderr
echo "mapred_job_id: $mapred_job_id" > /dev/stderr
echo "mapreduce_job_submithost: $mapreduce_job_submithost" > /dev/stderr

gdcmd="./vw -b 24 --total $mapred_map_tasks --node $mapper --unique_id $mapred_job_id --cache_file temp.cache --passes 1 --adaptive --exact_adaptive_norm -d /dev/stdin -f tempmodel --span_server $mapreduce_job_submithost --loss_function=logistic" 
mapred_job_id=`expr $mapred_job_id \* 2` #create new nonce
bfgscmd="./vw -b 24 --total $mapred_map_tasks --node $mapper --unique_id $mapred_job_id --cache_file temp.cache --bfgs --mem 5 --passes 20 --span_server $mapreduce_job_submithost -f model -i tempmodel --loss_function=logistic"
if [ "$mapper" == '000000' ]
then
    $gdcmd
    if [ $? -ne 0 ] 
    then
       exit 1
    fi 
    $bfgscmd
    outfile=$mapred_output_dir/model
    echo $outfile > /dev/stderr
    /opt/hadoop/bin/hadoop fs -put model $outfile
else
    $gdcmd
    if [ $? -ne 0 ]    
    then
       exit 1
    fi
    $bfgscmd
fi
