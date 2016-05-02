#!/bin/sh

echo -e "\e[34mWelcome to the push tag assistant by \e[36mgenfinternet\e[0m"

if [ $# -eq 0 ]; then
    echo -e -n "\e[34mFirst please enter the tag name: \e[0m"
    read -r tag
    while [ "$tag" = "" ] ; do
        echo -e -n "\e[34mPlease enter a tag name: \e[0m"
        read -r tag
    done
    echo -e -n "\e[34mNow please enter the tag token: \e[0m"
    read -r token
elif [ $# -le 2 ]; then
    tag=$1
    token=$2
else
    scriptname=`basename $0`
    echo -e "\e[33;1mUsage: $scriptname [TAG] [TOKEN]\e[0m"
    exit
fi

echo -e -n "\e[34mPress \`\e[36mEnter\e[34m' to confirm:\e[0m"

if [ "$token" != "" ]; then
    echo -e -n "\t\t\e[32;1mgit tag $tag -m "\"$token\""\e[0m"
else
    echo -e -n "\t\e[32;1mgit tag $tag \e[0m"
fi

read -r confirm

if [ "$token" != "" ]; then
    git tag $tag -m "$token"
else
    git tag $tag
fi

echo -e "\e[0;34mTag Created, now pushing to origin master\e[0m"
git push origin master $tag
