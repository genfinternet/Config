#!/bin/bash

if [ $# -gt 0 ]; then
    CURRENT_BDD=$1
fi

if [ "$LOCATION" = "home" ] | [ "$LOCATION" = "laptop" ]; then
    psql -l | grep -o -E "$CURRENT_BDD" >/dev/null 2>/dev/null
    if [ ! $? -eq 0 ]; then
        if [ "$FLAG_VERBOSE" = "on" ]; then
            echo -e -n "\e[34mCreating Database for user \`"
            echo -e -n "\e[36m$USER"
            echo -e -n "\e[34m' with the name \`"
            echo -e -n "\e[36m$CURRENT_BDD"
            echo -e "\e[34m'\e[0m"
        fi
        createdb -O $USER $CURRENT_BDD
    fi  
elif [ "$LOCATION" = "pxe" ]; then
    chmod 755 ~
    echo "echo \"\l\q\" | psql" | \su postgres | grep -o -E "$CURRENT_BDD" >/dev/null 2>/dev/null
    if [ ! $? -eq 0 ]; then
        if [ "$FLAG_VERBOSE" = "on" ]; then
            echo -e -n "\e[34mCreating Database for user \`"
            echo -e -n "\e[36m$USER"
            echo -e -n "\e[34m' with the name \`"
            echo -e -n "\e[36m$CURRENT_BDD"
            echo -e "\e[34m'\e[0m"
        fi
        echo "echo \"CREATE USER $USER; ALTER ROLE $USER SUPERUSER; CREATE DATABASE $CURRENT_BDD OWNER $USER; \q\" | psql" | \su postgres
    fi
    chmod 700 ~
fi
if [ $# -eq 0 ]; then
    psql -d $CURRENT_BDD -U $USER
elif [ $# -eq 1 ]; then
    psql -d $1 -U $USER
elif [ $# -ne 2 ]; then
    echo -e "\e[32;1mUsage: sql [BDD] [USER]\e[0m";
else
    psql -d $1 -U $2
fi
