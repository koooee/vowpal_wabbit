# TODO: how do we wrap an interface around this?
# FIXME: We are using a random number that isn't really a unique ID
#vw -b 24 --total 4 --node 4 --unique_id $RANDOM --cache_file temp.cache --spanserver master0 -f vwmodel --passes 1 --adaptive --exact_adaptive_norm -d /dev/stdin --regularization=1 --loss_function=logistic

./vw /dev/stdin -b 18 --total 4 --node 4 --unique_id $RANDOM -q ui --rank 10 --l2 0.001 \
  --learning_rate 0.025 --passes 20 --decay_learning_rate 0.97 --power_t 0 \
  -f movielens.reg --cache_file movielens.cache

