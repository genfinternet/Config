#!/bin/sh

function check()
{
    space=`grep --color=auto -E -n -H " $" $1`
    spacebool=$?
    toolong=`grep -E -n -H --color=auto ".{81,}" $1`
    toolongbool=$?
    keyword=`grep -E -n -H --color=auto " (for|if|while|sizeof)\(" $1`
    keywordbool=$?
    par=`grep -E -n -H --color=auto "(\( )|( \))" $1`
    parbool=$?
    tab=`grep -E -n -H --color=auto "	" $1`
    tabbool=$?
    coma=`grep -E -n -H --color=auto "(,|;)[^ ]" $1`
    comabool=$?
    if [ $spacebool -eq 1 ] && [ $toolongbool -eq 1 ] && [ $keywordbool -eq 1 ] && [ $parbool -eq 1 ] && [ $tabbool -eq 1 ] && [ $comabool -eq 1 ]; then
        echo -e "\e[34;1;4m"$1"\e[0;34;1m : \e[32mOK\e[0m";
    else
        echo -e "\e[31;1;4m"$1"\e[0;31;1m :\e[0m";
        echo ""
        if [ $tabbool -eq 0 ]; then
            echo -e -n "$tab\n" | while read -r i; do
            echo -n -e "  \e[1;33mTabulation detected :\e[0m ";
                echo $i;
            done;
        else 
            echo -e "  \e[1mNo tabulation!";
        fi
        echo ""
        if [ $comabool -eq 0 ]; then
            echo -e -n "$coma\n" | while read -r i; do
            echo -n -e "  \e[1;33mMissing Space after ',' or ';':\e[0m ";
                echo $i;
            done;
        else 
            echo -e "  \e[1mNo problem with coma, not semi-colon!";
        fi
        echo ""
        if [ $parbool -eq 0 ]; then
            echo -e -n "$par\n" | while read -r i; do
            echo -n -e "  \e[1;33mSpace after '(' or before ')' :\e[0m ";
                echo $i;
            done;
        else 
            echo -e "  \e[1mNo problem with parenthesis!";
        fi
        echo ""
        if [ $spacebool -eq 0 ]; then
            echo -e -n "$space\n" | while read -r i; do
                echo -n -e "  \e[1;33mEnd of line space :\e[0m ";
                echo $i;
            done;
        else 
            echo -e "  \e[1mNo space at the end of line!";
        fi
        echo ""
        if [ $toolongbool -eq 0 ]; then
            echo -e -n "$toolong\n" | while read -r i; do
                    echo -n -e "  \e[1;33mLine too long :\e[0m ";
                echo $i;
            done;
        else
            echo -e "  \e[1mNo line longer than 80 char!";
        fi
        echo ""
        if [ $keywordbool -eq 0 ]; then
            echo -e -n "$keyword\n" | while read -r i; do
                echo -n -e "  \e[1;33mSpace after keyword :\e[0m ";
                echo $i;
            done;
            else
            echo -e "  \e[1mNo space after keywords!";
        fi
        echo ""
        if [ "`cat $1 | tail -n 1 |grep -E -n -H "^( )*$" `" != "" ]; then
            echo -e "  \e[31;1;5m/!\\ \e[33;1;5mNew line at the end \e[31;1;5m/!\\ \e[0m";
        fi
    fi
    echo "";
}

function ccs()
{
    echo -e "\e[96;1mCoding style check tool by \e[92;1mgenfinternet\e[0m"
    echo -e "\e[96;1mAnalyzing all file in directory and sub-directory...\e[0m"
    if [ $# -gt 0 ]; then
        file=$@
    else
        file=`find . | grep -E "\.(cc|c|h|hh|hxx)$"`
    fi
    for i in $file; do
        check $i;
    done;
}

ccs $@
