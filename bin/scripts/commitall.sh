#!/bin/sh

if ! git ls-files 2>/dev/null >/dev/null; then
  echo >&2 -e "\e[33;1mThis is not a git directory, aborting...\e[0m"
  exit
fi

UNTRACKED='git ls-files --other --exclude-standard'
DELETED='git ls-files --deleted'
MODIFIED='git ls-files --modified'

if [ -f "./build.xml" ]; then
  git add build.xml
  git commit -m "Add build.xml"
fi
if [ -f "./build.xml" ]; then
  git add build.xml
  git commit -m "Add build.xml"
fi
if [ -f "./Makefile" ]; then
  git add Makefile
  git commit -m "Add Makefile"
fi
for i in $@; do
  for i in `$UNTRACKED | grep -E "\.$i\$"`; do
    git add $i
    git commit -m"Add `basename $i | sed -E "s/(.*)\.(.*)/\2 file : \1/g"`"
  done
done
for i in $@; do
  for i in `$DELETED | grep -E "\.$i\$"`; do
    git add $i
    git commit -m"Delete `basename $i | sed -E "s/(.*)\.(.*)/\2 file : \1/g"`"
  done
done
for i in $@; do
  for i in `$MODIFIED | grep -E "\.$i\$"`; do
    git add $i
    git commit -m"Update `basename $i | sed -E "s/(.*)\.(.*)/\2 file : \1/g"`"
  done
done
