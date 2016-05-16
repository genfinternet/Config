#!/bin/sh
source ~/.bashrc
function print_help()
{
    echo >&2 -e "\e[33;1mUsage: $0 DIRECTORY [REMOTE]\e[0m"
    echo >&2 -e "\e[33;1m- DIRECTORY: Name of directory to create (use . for current)\e[0m"
    echo >&2 -e "\e[33;1m- REMOTE   : URL of the remote (Optionnal)\e[0m"
    exit $1
}

function start_mkrepo()
{
    if [ -e "$1/.git" ]; then
        echo >&2 -e "\e[31;1mThis directory is already a git repository.\e[0m"
        echo >&2 -e "\e[31;1mAborting.\e[0m"
        exit 1
    fi

    if [ "$1" != "." ]; then
        if ! [ -e "$1" ]; then
            mkdir -p $1
        fi
        cd $1
    fi
    git init
    if [ "$FLAG_REMOTE" = true ]; then
        git remote add origin $REMOTE
    fi
    AUTHORS
    ngitignore
    nREADME
    nTODO
    git add AUTHORS
    git commit -m "Project Creation: Authors"
    git add README TODO .gitignore
    git commit -m "Add Files       : TODO README .gitignore

TODO: Empty
README: Empty
.gitignore: Default settings"
    mkdir src
    mkdir tests
    mkdir lib
    mkdir rsrc
    #Add build.xml / Makefile here depending on priority picks
}

for i in $@; do
    if [ "$i" = "--help" ] || [ "$i" = "-h" ]; then
        print_help 0
    fi
done

case $# in
    1)
        FLAG_REMOTE="false"
        start_mkrepo $1
        ;;
    2)
        FLAG_REMOTE="true"
        REMOTE="$2"
        start_mkrepo $1
        ;;
    *)
        print_help 1
        ;;
esac
