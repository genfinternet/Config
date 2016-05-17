#!/bin/sh

source ~/.export.sh

nohup ~/.my_bin/epi3lock -i $LOCKSCREEN &

pid=$!

if [ "$DEADLOCK" = "true" ]; then
    $CONFIG_GIT_DIR/bin/scripts/dead_clock.sh &
    pidbis=$!
    wait $pid
    read
    kill $pidbis
fi
wait $pid
