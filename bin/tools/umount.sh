#!/bin/sh

if [ $# -eq 0 ]; then
    ls ~/MountDirectory | pr -tw123 -3
    echo -e "\e[34;1mPlease enter the device you wish to unmount\e[0m"
    read -r i
else
    i="$1"
fi
echo -e "\e[34;1mUnmounting device \`\e[35;1m$i\e[34;1m'\e[0m"
cd ~/MountDirectory
sudo umount ~/MountDirectory/$i
if [ $? -eq 0 ]; then
    rm -r $i
fi
