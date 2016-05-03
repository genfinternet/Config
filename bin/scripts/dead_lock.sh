#!/bin/sh

~/.my_bin/epi3lock -i ~/wallpaper/lock2.png &
pid=$!
$CONFIG_GIT_DIR/bin/scripts/dead_clock.sh &
pidbis=$!
wait $pid
read
kill $pidbis
