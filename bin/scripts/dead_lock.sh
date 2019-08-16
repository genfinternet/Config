#!/bin/bash

source ~/.export.sh



if [ "$DEADLOCK" = "true" ]; then
    ~/.my_bin/epi3lock -i $LOCKSCREEN &
    pid=$!
    $CONFIG_GIT_DIR/bin/scripts/dead_clock.sh &
    pidbis=$!
    wait $pid
    read
    kill $pidbis
else
    nohup ~/.my_bin/epi3lock -i $LOCKSCREEN &
fi
wait $pid
