#!/bin/sh
if [ $# -eq 0 ]; then
    echo -e "\e[33;1mUsage: get_constructor.sh name \e[0m"
fi
for i in $@; do
    filename=$1""hh
    a=`basename $1""hh | grep -E -o "^[a-z]+(-[a-z]+)*"`
    name=`echo $a | sed "s/\([a-z]\)/\L\1/g"` 
    class=`echo $name | sed "s/-\([a-z]\)/\U\1/g" | sed "s/\(^[a-z]\)/\U\1/g"`
    grep -E -i " $class\((.)*\)" $filename >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        grep -E -i " $class\((.)*\);" $filename
    else
        grep -E -i -A1 " $class\(" $filename
    fi
    shift
done
