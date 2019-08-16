#!/bin/bash

if [ $# -eq 0 ]; then
    timer=3539;
elif [ $# -eq 1 ]; then
    timer=$1
else
    echo -e "\e32;mUsage:./dead_clock.sh [TIME IN SEC]\e[0m"
    exit
fi
SECONDS=0
while true; do
    remaining=$(($timer - $SECONDS))
    sec_print=$(($remaining % 60))
    min_print=$(($remaining / 60))
    if [ $sec_print -lt 10 ]; then 
        echo -e -n "\rYou have $min_print"":0$sec_print before the end of the dead clock"
    else    
        echo -e -n "\rYou have $min_print"":$sec_print before the end of the dead clock"
    fi
    if [ $SECONDS -ge $timer ]; then
        i3-msg exit
        exit;
    fi
    sleep 1;
done
