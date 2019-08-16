#!/bin/bash

if [ $# -eq 1 ] && [ "$1" = "change" ]; then
    echo -e "\e[34;1mEnter current password\e[0m"
    stty_orig=`stty -g` # save original terminal setting.
    stty -echo          # turn-off echoing.
    read passwd         # read the password
    stty $stty_orig     # restore terminal setting.
    if [ "$passwd" != `base64 -d ~/.promptwickeddirectory` ]; then
        echo -e "\e[31;1mWrong password\e[0m"
        exit 1
    fi
    echo -e "\e[34;1mEnter password\e[0m"
    stty_orig=`stty -g` # save original terminal setting.
    stty -echo          # turn-off echoing.
    read passwd         # read the password
    stty $stty_orig     # restore terminal setting.
    echo -e "\e[34;1mEnter same password\e[0m"
    stty -echo          # turn-off echoing.
    read passwd2         # read the password
    stty $stty_orig     # restore terminal setting.
    if [ "$passwd" = "" ]; then
        echo -e "\e[33;1mPassword can't be empty\e[0m"
    elif [ "$passwd" = "$passwd2" ]; then
        echo -e "\e[32;1mOkay\e[0m"
        (echo $passwd | base64) >~/.promptwickeddirectory
    else
        echo -e "\e[33;1mThe two password don't match please try again\e[0m"
    fi
    exit 0
elif [ -f ~/.promptwickeddirectory ]; then
    echo -e "\e[34;1mEnter current password\e[0m"
    stty_orig=`stty -g` # save original terminal setting.
    stty -echo          # turn-off echoing.
    read passwd         # read the password
    stty $stty_orig     # restore terminal setting.
    if [ "$passwd" = `base64 -d ~/.promptwickeddirectory` ]; then
        exit 0
    else
        echo -e "\e[31;1mWrong password\e[0m"
        exit 1
    fi
else
    echo -e "\e[34;1mPassword has never been set, please create one\e[0m"
    echo -e "\e[34;1mEnter password\e[0m"
    stty_orig=`stty -g` # save original terminal setting.
    stty -echo          # turn-off echoing.
    read passwd         # read the password
    stty $stty_orig     # restore terminal setting.
    echo -e "\e[34;1mEnter same password\e[0m"
    stty -echo          # turn-off echoing.
    read passwd2         # read the password
    stty $stty_orig     # restore terminal setting.
    if [ "$passwd" = "" ]; then
        echo -e "\e[33;1mPassword can't be empty\e[0m"
    elif [ "$passwd" = "$passwd2" ]; then
        echo -e "\e[32;1mOkay\e[0m"
        (echo $passwd | base64) >~/.promptwickeddirectory
    else
        echo -e "\e[33;1mThe two password don't match please try again\e[0m"
    fi
    exit 0
fi
