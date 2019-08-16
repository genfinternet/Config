#!/bin/bash

if [ $# -eq 1 ]; then
    for i in $SUPPORTED_EXTENTIONS;  do
        var="$i|$var"
    done
    var=`echo $var | sed "s/|$//g"`
    var=`find . | grep -E "\.($var)$"`
    if [ $? -eq 0 ]; then
        grep --color=auto -E -n "$1" $var
        if [ $? -ne 0 ]; then 
            echo -e "\e[1;33mNothing found in files "$var"\e[0m"
        fi
    else
        echo -e "\e[1;31mNo file found\e[0m"
    fi
else
    if [ $# -eq 2 ]; then
        var=`find . | grep -E "$2"`
        if [ $? -eq 0 ]; then 
            grep --color=auto -E -n "$1" $var
            if [ $? -ne 0 ]; then 
                echo -e "\e[1;33mNothing found in files "$var"\e[0m"
            fi
        else
            echo -e "\e[1;31mNo file found\e[0m"
        fi
    fi

fi
