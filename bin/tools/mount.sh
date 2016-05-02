#!/bin/sh

if [ $# -eq 0 ]; then
    ls /dev/ | grep 'sd' | pr -tw123 -3
    echo -e "\e[34;1mPlease enter the device you wish to mount\e[0m"
    read -r i
else
    i="$1"
fi
echo -e "\e[34;1mMounting device \`\e[35;1m$i\e[34;1m'\e[0m"
cd ~/MountDirectory
mkdir -p $i
sudo mount -o umask=0000 /dev/$i $i
if [ $? -ne 0 ]; then
   rm -r $i
fi 
