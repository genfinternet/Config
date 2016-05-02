#!/bin/sh

~/.my_bin/epi3lock -i ~/wallpaper/lock2.png &
pid=$!
~/Config/bin/scripts/dead_clock.sh &
pidbis=$!
wait $pid
read
kill $pidbis
