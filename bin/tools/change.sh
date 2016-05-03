#!/bin/sh

FILE_BASH="$HOME/.export.sh"

function reload_bash()
{
    source $FILE_BASH
}

function revert_change()
{
    change_$LAST_CHANGED $LAST_CHANGE 
}

function change_verbose()
{
    LAST_CHANGED="verbose"
    LAST_CHANGE=`grep -E "export FLAG_VERBOSE=\".*\"" $FILE_BASH | sed "s/export FLAG_VERBOSE=\"\(.*\)\"/\1/g"`
    new=""
    for i in $@; do
        new="$i $new"
    done
    new=`echo $new | sed "s/\s*$//g"`
    sed "s/export FLAG_VERBOSE=\"\(.*\)\"/export FLAG_VERBOSE=\"$new\"/g" $FILE_BASH -i
    echo -e "\e[34mChanging value for 'FLAG_VERBOSE' from '$LAST_CHANGE' to '$@'"
    reload_bash
}

function change_debug()
{
    LAST_CHANGED="debug"
    LAST_CHANGE=`grep -E "export FLAG_DEBUG=\".*\"" $FILE_BASH | sed "s/export FLAG_DEBUG=\"\(.*\)\"/\1/g"`
    new=""
    for i in $@; do
        new="$i $new"
    done
    new=`echo $new | sed "s/\s*$//g"`
    sed "s/export FLAG_DEBUG=\"\(.*\)\"/export FLAG_DEBUG=\"$new\"/g" $FILE_BASH -i
    echo -e "\e[34mChanging value for 'FLAG_DEBUG' from '$LAST_CHANGE' to '$@'"
    reload_bash
}

function change_project()
{
    LAST_CHANGED="project"
    LAST_CHANGE=`grep -E "export CURRENT_PROJECT=\".*\"" $FILE_BASH | sed "s/export CURRENT_PROJECT=\"\(.*\)\"/\1/g"`
    new=""
    for i in $@; do
        new="$i $new"
    done
    new=`echo $new | sed "s/\s*$//g"`
    sed -e "s/export CURRENT_PROJECT=\".*\"/export CURRENT_PROJECT=\"$new\"/g" $FILE_BASH -i
    echo -e "\e[34mChanging value for 'CURRENT_PROJECT' from '$LAST_CHANGE' to '$@'"
    reload_bash
}

function change_bdd()
{
    LAST_CHANGED="bdd"
    LAST_CHANGE=`grep -E "export CURRENT_BDD=\".*\"" $FILE_BASH | sed "s/export CURRENT_BDD=\"\(.*\)\"/\1/g"`
    new=""
    for i in $@; do
        new="$i $new"
    done
    new=`echo $new | sed "s/\s*$//g"`
    sed -e "s/export CURRENT_BDD=\".*\"/export CURRENT_BDD=\"$new\"/g" $FILE_BASH -i
    echo -e "\e[34mChanging value for 'CURRENT_BDD' from '$LAST_CHANGE' to '$@'"
    reload_bash
}

function change_tiger()
{
    LAST_CHANGED="tiger"
    LAST_CHANGE=`grep -E "export TIGER_DIR=\".*\"" $FILE_BASH | sed "s/export TIGER_DIR=\"\(.*\)\"/\1/g"`
    new=""
    for i in $@; do
        new="$i $new"
    done
    new=`echo $new | sed "s/\s*$//g"`
    sed -e "s!export TIGER_DIR=\".*\"!export TIGER_DIR=\"$new\"!g" $FILE_BASH -i
    echo -e "\e[34mChanging value for 'TIGER_DIR' from '$LAST_CHANGE' to '$@'"
    reload_bash
}

function change_picks()
{
    LAST_CHANGED="picks"
    LAST_CHANGE=`grep -E "export PRIORITY_PICKS=\".*\"" $FILE_BASH | sed "s/export PRIORITY_PICKS=\"\(.*\)\"/\1/g"`
    new=""
    for i in $@; do
        new="$i $new"
    done
    new=`echo $new | sed "s/\s*$//g"`
    sed -e "s/export PRIORITY_PICKS=\".*\"/export PRIORITY_PICKS=\"$new\"/g" $FILE_BASH -i
    echo -e "\e[34mChanging value for 'PRIORITY_PICKS' from '$LAST_CHANGE' to '$@'"
    reload_bash
}

function change_files()
{
    LAST_CHANGED="files"
    LAST_CHANGE=`grep -E "export SUPPORTED_EXTENTIONS=\".*\"" $FILE_BASH | sed "s/export SUPPORTED_EXTENTIONS=\"\(.*\)\"/\1/g"`
    new=""
    for i in $@; do
        new="$i $new"
    done
    new=`echo $new | sed "s/\s*$//g"`
    sed "s/export SUPPORTED_EXTENTIONS=\"\(.*\)\"/export SUPPORTED_EXTENTIONS=\"$new\"/g" $FILE_BASH -i
    echo -e "\e[34mChanging value for 'SUPPORTED_EXTENTION' from '$LAST_CHANGE' to '$@'"
    reload_bash
}

if [ $# -lt 1 ]; then
    echo -e "\e[33;1mUsage: change FLAG VALUE\e[0m"
else
    case $1 in
        verbose)    shift; change_verbose $@;;
        debug)      shift; change_debug $@;;
        picks)      shift; change_picks $@;;
        files)      shift; change_files $@;;
        project)    shift; change_project $@;;
        bdd)        shift; change_bdd $@;;
        tiger)      shift; change_tiger $@;;
        revert)     revert_change;;
        *)          echo -e "\e[33;1mInvalid flag, use verbose, debug, picks, files, project, bdd, tiger or revert\e[0m";;
    esac
fi
