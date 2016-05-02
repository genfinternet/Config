#!/bin/sh

check_user()
{
    if [ $# -ne 1 ]; then
        exit
    else
        echo -e "\e[34;1mChecking your file... \e[0m"
        if [ -f ~/Config/other/modifbash/$1.dataconfig ]; then
            echo -e "\e[32;1mFound your file !\e[0m"
        else
            echo -e "\e[33;1mSeems like you're a new user, welcome !\e[0m"
            echo -e -n "\e[34;1mFile created\nPress enter to see my bashrc\e[0m"
            read
            touch ~/Config/other/modifbash/$1.dataconfig
            diff -s ~/Config/other/modifbash/$1.dataconfig ~/.shellrc.sh | less
            cp ~/.shellrc.sh ~/Config/other/modifbash/$1.dataconfig
            exit
        fi
        if [ ~/Config/other/modifbash/$1.dataconfig -ot ~/.shellrc.sh ]; then
            echo -e -n "\e[32;1mChange found, press enter to see them\e[0m"
            read
            touch ~/Config/other/modifbash/$1.dataconfig
            diff -s ~/Config/other/modifbash/$1.dataconfig ~/.shellrc.sh | less
            cp ~/.shellrc.sh ~/Config/other/modifbash/$1.dataconfig
        else
            echo -e "\e[31;1mNothing new since last time\e[0m"
        fi
    fi
}

modifbash()
{
    if [ $# -eq 0 ]; then
        echo -e "\e[34;1mSince no argument was given I will assume it was \e[35;1m\`Morali'\e[34;1m asking\e[0m"
        check_user "Morali"
    elif [ $# -eq 1 ]; then
        if [ $1 = "-h" ]; then
            bin=`basename $0`
            echo "Usage : $bin [ID_ASKING]"
            exit
        elif [ $1 = "--help" ]; then
            bin=`basename $0`
            echo "Usage : $bin [ID_ASKING]"
            exit
        elif [ $1 = "Morali" ]; then 
            echo -e "\e[34;1mHey \`\e[35;1mMorali'\e[34;1m pas de besoin d'ID pour toi\e[0m"
        else
            echo -e "\e[34;1mHello \`\e[35;1m$1'\e[0;1m\e[0m"
        fi
        check_user $1
    else
        bin=`basename $0`
        echo "Usage : $bin [ID_ASKING]"
    fi
}
if [ $# -gt 0 ]; then 
    if [ $1 = "clean" ]; then
        rm -i ~/Config/other/modifbash/*
        shift
        exit
    elif [ $1 = "notclean" ]; then
        shift
    fi
fi
modifbash $@
