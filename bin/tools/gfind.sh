#!/bin/bash

list_file=""
if [ $# -eq 1 ]; then
  var=`find . | grep -E $1`
  nb=`echo $var | sed "s/ /\n/g" | wc -l`
  if [ $nb -gt 500 ]; then
    echo >&2 "A lot of files were found so the result won't be sorted"
    echo $var | sed "s/ /\n/g"
    exit
  fi
  if [ $? -ne 0 ]; then
    echo -e "\e[31;1mNo file found with this name\e[0m"
  fi
  for i in $var; do
    temp=`basename $i`
    echo $temp | grep -E "$1" >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
      list_file="$list_file $i"
    fi
  done
  for i in $list_file; do
    if [ -d $i ]; then
      list_dir="$list_dir $i"
    else
      list_files="$list_files $i"
    fi
  done

  if [ "$list_dir" != "" ]; then
    echo >&2 -e "\e[34;1mDirectories:\e[0m"
    for i in $list_dir; do
      echo $i | grep -E --color=auto "$1"
    done
  fi
  if [ "$list_files" != "" ]; then
    echo >&2 -e "\e[34;1mFiles:\e[0m"
    for i in $list_files; do
      echo $i | grep -E --color=auto "$1"
    done
  fi
fi
