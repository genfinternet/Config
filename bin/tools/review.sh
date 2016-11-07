#!/bin/bash
clear
echo -n -e "\033[36;1mStarting Review script\033[0m"
read -r
for i in `git ls-files -m`; do
  clear
  echo -n -e "\033[36;1mReviewing $i:\033[0m"
  read -r
  echo -e "\033[36;1m------------------------------------------------------------------------------\033[0m"
  git diff $i
  echo -e "\033[36;1m------------------------------------------------------------------------------\033[0m"
  echo -n -e "\033[36;1mDo you wish to add $i [Y/n]\033[0m:"
  read -r choice
  if [ "$choice" == "n" ] || [ "$choice" == "N" ]; then
    echo -e "\033[36;1mSkipped!\033[0m"
  else
    git add $i
    echo -e "\033[36;1mAdded\033[0m"
  fi
  echo -n -e "\033[36;1mPress enter to continue\033[0m"
  read -r
done
