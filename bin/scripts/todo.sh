#!/bin/sh


alias RESET='echo -e -n "\e[0m"'
alias NORMAL='echo -e -n "\e[34m"'
alias STRONG='echo -e -n "\e[36m"'

alias BOLD='echo -e -n "\e[1m"'
alias LINE='echo -e -n "\e[4m"'

alias GOOD='echo -e -n "\e[32m"'
alias BAD='echo -e -n "\e[33m"'
alias ERROR='echo -e -n "\e[31m"'

REGEX_NAME="[a-zA-Z]+(( |\.|_|/|-\(|\))[a-zA-Z0-9]+)*"
REGEX_ADV="\|( |-){10}\|"
ADV_PROJECT=""
PROJECT=""
ADV_THRESH=""
THRESHOLD=""
ADV_EXE=""
EXERCICE=""
NB_P=0
NB_T=0
NB_E=0

function bar_to_nb()
{
    case "$1" in
        \|----------\|)
            GOOD
            echo "100%"
            RESET
            ;;
        \|---------\ \|)
            BAD
            echo "90%"
            RESET
            ;;
        \|--------\ \ \|)
            BAD
            echo "80%"
            RESET
            ;;
        \|-------\ \ \ \|)
            BAD
            echo "70%"
            RESET
            ;;
        \|------\ \ \ \ \|)
            BAD
            echo "60%"
            RESET
            ;;
        \|-----\ \ \ \ \ \|)
            BAD
            echo "50%"
            RESET
            ;;
        \|----\ \ \ \ \ \ \|)
            BAD
            echo "40%"
            RESET
            ;;
        \|---\ \ \ \ \ \ \ \|)
            BAD
            echo "30%"
            RESET
            ;;
        \|--\ \ \ \ \ \ \ \ \|)
            BAD
            echo "20%"
            RESET
            ;;
        \|-\ \ \ \ \ \ \ \ \ \|)
            BAD
            echo "10%"
            RESET
            ;;
        \|\ \ \ \ \ \ \ \ \ \ \|)
            BAD
            echo "0%"
            RESET
            ;;
        *)
            echo -e "$ERROR""NaN""$RESET";;
    esac
}

function add__()
{
    if [ $# -eq 2 ]; then
        SW_P=$1
        SW_T=0
        SW_E=0
        shift
    elif [ $# -eq 3 ]; then
        SW_P=$1
        SW_T=$2
        SW_E=0
        shift
        shift
    elif [ $# -eq 4 ]; then
        SW_P=$1
        SW_T=$2
        SW_E=$3
        shift
        shift
        shift
    else
       return
   fi 
    while read -r line; do
        case "$line" in
            *\#\ *)
                NB_P=$(($NB_P + 1))
                NB_E=0
                NB_T=0
                if [ $NB_P -eq $SW_P ] && [ $SW_T -eq 0 ]; then
                    sed -E "s@# $line@$line\n # $1 |          |   0%@" TODO -i
                    return
                fi
                ;;
            *\*\ *)
                NB_T=$(($NB_T + 1))
                NB_E=0

                if [ $NB_P -eq $SW_P ] && [ $SW_T -eq $NB_T ] && [ $SW_E -eq 0 ]; then
                    PROJECT=`echo "$line" | grep -E -o "$REGEX_NAME"`;
                    sed -E "s@\* $PROJECT@\* $1@g" TODO -i
                    return
                fi
                ;;
            *-\ *)
                NB_E=$(($NB_E + 1))

                if [ $NB_P -eq $SW_P ] && [ $SW_T -eq $NB_T ] && [ $SW_E -eq $NB_E ]; then
                    PROJECT=`echo "$line" | grep -E -o "$REGEX_NAME"`;
                    sed -E "s@- $PROJECT@- $1@g" TODO -i
                    return
                fi
                ;;
            "*")
                ;;
        esac
    done
}

function rename()
{
    if [ $# -eq 2 ]; then
        SW_P=$1
        SW_T=0
        SW_E=0
        shift
    elif [ $# -eq 3 ]; then
        SW_P=$1
        SW_T=$2
        SW_E=0
        shift
        shift
    elif [ $# -eq 4 ]; then
        SW_P=$1
        SW_T=$2
        SW_E=$3
        shift
        shift
        shift
    else
       return
   fi 
    while read -r line; do
        case "$line" in
            *\#\ *)
                NB_P=$(($NB_P + 1))
                NB_E=0
                NB_T=0
                if [ $NB_P -eq $SW_P ] && [ $SW_T -eq 0 ]; then
                    PROJECT=`echo "$line" | grep -E -o "$REGEX_NAME"`;
                    sed -E "s@# $PROJECT@# $1@g" TODO -i
                    return
                fi
                ;;
            *\*\ *)
                NB_T=$(($NB_T + 1))
                NB_E=0

                if [ $NB_P -eq $SW_P ] && [ $SW_T -eq $NB_T ] && [ $SW_E -eq 0 ]; then
                    PROJECT=`echo "$line" | grep -E -o "$REGEX_NAME"`;
                    sed -E "s@\* $PROJECT@\* $1@g" TODO -i
                    return
                fi
                ;;
            *-\ *)
                NB_E=$(($NB_E + 1))

                if [ $NB_P -eq $SW_P ] && [ $SW_T -eq $NB_T ] && [ $SW_E -eq $NB_E ]; then
                    PROJECT=`echo "$line" | grep -E -o "$REGEX_NAME"`;
                    sed -E "s@- $PROJECT@- $1@g" TODO -i
                    return
                fi
                ;;
            "*")
                ;;
        esac
    done
}

function decode()
{
    while read -r line; do
        case "$line" in
            *\#\ *)
                NB_P=$(($NB_P + 1))
                NB_E=0
                NB_T=0

                PROJECT=`echo "$line" | grep -E -o "$REGEX_NAME"`;
                ADV_PROJECT=`echo "$line" | grep -E -o "$REGEX_ADV"`;
                NORMAL
                echo -n "$NB_P) "
                RESET
                STRONG
                BOLD
                LINE
                echo -n "$PROJECT: "
                RESET
                bar_to_nb "$ADV_PROJECT"
                ;;
            *\*\ *)
                NB_T=$(($NB_T + 1))
                NB_E=0

                THRESHOLD=`echo "$line" | grep -E -o "$REGEX_NAME"`;
                ADV_THRESH=`echo "$line" | grep -E -o "$REGEX_ADV"`;
                NORMAL
                echo -n -e "    $NB_P.$NB_T) "
                RESET
                STRONG
                LINE
                echo -n -e "$THRESHOLD: "
                RESET
                bar_to_nb "$ADV_THRESH"
                ;;
            *-\ *)
                NB_E=$(($NB_E + 1))

                EXERCICE=`echo "$line" | grep -E -o "$REGEX_NAME"`;
                ADV_EXE=`echo "$line" | grep -E -o "$REGEX_ADV"`;
                NORMAL
                echo -n -e "        $NB_P.$NB_T.$NB_E) "
                RESET
                STRONG
                echo -n -e "$EXERCICE: "
                RESET
                bar_to_nb "$ADV_EXE"
                ;;
            "*")
                ;;
        esac
    done
}

function print_help()
{
    RESET
    NORMAL
    echo "Usage:"
    echo -n "- "
    STRONG
    echo -n "print    "
    NORMAL
    echo ": Print the TODO and the advancement."
    echo -n "- "
    STRONG
    echo -n "add      "
    NORMAL
    echo ": Add a category."
    echo -n "- "
    STRONG
    echo -n "progress "
    NORMAL
    echo ": Change progress."
    echo -n "- "
    STRONG
    echo -n "rename   "
    NORMAL
    echo ": Rename a category."
    echo -n "- "
    STRONG
    echo -n "clear    "
    NORMAL
    echo ": Clear the screen."
    echo -n "- "
    STRONG
    echo -n "exit     "
    NORMAL
    echo ": Exit the assistant."
}

function add_part()
{
    cat TODO | add $@
}

function rename_part()
{
    cat TODO | rename $@
}

function print_todo()
{
    cat TODO | decode
}

function menu()
{
    if [ ! -f TODO ]; then
        if [ -e TODO ]; then
            BAD
            echo "There is already a file named TODO, but it's not a regular file"
            RESET
            return
        fi
        NORMAL
        echo -n "No TODO found, do you want to create one ("
        LINE
        echo -n "yes"
        RESET
        NORMAL
        echo -n "/no): "
        STRONG
        read -r choice
        NORMAL
        if [ "$choice" != "no" ]; then
            echo "In this file you'll find and approximate advancement my work per exercice." >TODO
            echo "" >>TODO
            echo "---------------------------| START |----------------------------" >>TODO
            echo "" >>TODO
            echo " # PROJECT                                      |          |   0%" >>TODO
            echo "" >>TODO
            echo "    * THRESHOLD 1                               |          |   0%" >>TODO
            echo "" >>TODO
            echo "        - exercice_1                            |          |   0%" >>TODO
            echo "        - exercice_2                            |          |   0%" >>TODO
            echo "" >>TODO
            echo "---------------------------|  END  |----------------------------" >>TODO
        else
            echo "Aborting..."
            exit
        fi
    fi
    if [ $# -eq 0 ]; then
    RESET
    NORMAL
    echo -n "Hi, Welcome to the"
    STRONG
    echo -n " TODO "
    RESET
    NORMAL
    echo -n "assistant by"
    STRONG
    echo -n " genfinternet"
    RESET
    NORMAL
    echo -e -n ".\nEnter a command (help/exit): "
    RESET
    STRONG
    while read -r choice; do
        RESET
        NORMAL
        option=`echo $choice | sed -E "s/^[a-z]+\s*(.*)/\1/g"`
        choice=`echo $choice | sed -E "s/^([a-z]+)\s*.*/\1/g"`
        case $choice in
            help)
                print_help
                ;;
            cl)
                clear;;
            cat)
                RESET
                cat $option;;
            ls)
                ls --color=auto;;
            print)
                print_todo
                ;;
            exit)
                echo "Good bye"
                RESET
                exit $option 2>/dev/null
                ;;
            rename)
                rename_part "$option"
                ;;
            add)
                add_part "$option"
                ;;
            progress)
                echo "progress $option"
                BAD
                echo "Not Yet Implemented"
                ;;
            *)
                BAD
                echo "This command does not exist"
                ;;
        esac
        RESET
        NORMAL
        echo -e -n "Enter a command (help/cmd): "
        RESET
        STRONG
    done
    echo
    else
        choice="$@"
        option=`echo $choice | sed -E "s/^[a-z]+\s*(.*)/\1/g"`
        choice=`echo $choice | sed -E "s/^([a-z]+)\s*.*/\1/g"`
        shift
        case $choice in
            help)
                print_help
                ;;
            print)
                print_todo
                ;;
            rename)
                rename_part "$option"
                ;;
            add)
                echo "add $option"
                BAD
                echo "Not Yet Implemented"
                ;;
            progress)
                echo "progress $option"
                BAD
                echo "Not Yet Implemented"
                ;;
            *)
                BAD
                echo "This command does not exist"
                ;;
        esac
    fi
}

menu $@
