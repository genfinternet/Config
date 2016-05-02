# # # # # # # # # # # # # # # # # #
#                                   #
#         @@@@@@@@@@@@@@@@@@        #
#         @@@@@@@@@@@@@@@@@@        #
#         @@@@@@@@@@@@@@@@@@        #
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  #
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  #
#   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  #
#   @@@@@@      @@@@@@      @@@@@@  #
#   @@@@@@      @@@@@@      @@@@@@  #
#   @@@@@@      @@@@@@      @@@@@@  #
#         @@@@@@@@@@@@@@@@@@        #
#         @@@@@@@@@@@@@@@@@@        #
#         @@@@@@@@@@@@@@@@@@        #
#   @@@@@@      @@@@@@      @@@@@@  #
#   @@@@@@      @@@@@@      @@@@@@  #
#   @@@@@@      @@@@@@      @@@@@@  #
#                                   #
# # # # # # # # # # # # # # # # #  


##############################
#                            #
#          EXPORTS           #
#                            #
##############################
source ~/.export.sh

export NNTPSERVER=news.epita.fr
#export CC="perl ~/Config/bin/colorgcc.perl"


if [ $LOCATION = "laptop" ]; then
    eval $(thefuck --alias)
    export MAKE_OPTION=""
elif [ $LOCATION = "pxe" ]; then
    export MAKE_OPTION="-j8"
elif [ $LOCATION = "home" ]; then
    eval $(thefuck --alias)
    export MAKE_OPTION="-j8"
else
    echo -e "\e[33mUnknown location\e[0m"
fi

if [ $SHELL = "bash" ]; then
    export PROMPT_COMMAND=prompt
    function prompt()
    {
        EXIT=$?
        green=$(tput setaf 2)
        blue=$(tput setaf 4)
        yellow=$(tput setaf 3)
        red=$(tput setaf 1)
        bold=$(tput bold)
        reset=$(tput sgr0)
        PS1="\[\$reset\]\[\$bold\]"
        if [ $EXIT -eq 0 ]; then
            PS1+=""
        elif [ $EXIT -gt 127 ] && [ $EXIT -lt 160 ]; then
            PS1+="\[\$yellow\]"
            PS1+="$EXIT "
        else
            PS1+="\[\$red\]"
            PS1+="$EXIT "
        fi
        PS1+="\[\$green\]Genf : \[\$blue\]\W/ \[\$green\]>> \[\$reset\]"
    }
    export PS2="\e[32;1m>> \e[0m"
    alias srcsh='source ~/.bashrc'
else
    setopt PROMPT_SUBST
    HISTFILE=~/.histfile
    HISTSIZE=5000
    SAVEHIST=5000
    export PS1="%B%F{green}Genf : %F{blue}PATH %F{green}>> %b%f"
    export PS2="\e[32;1m>> \e[0m"
    alias srcsh='source ~/.zshrc'
fi

##############################
#                            #
#        CD ALIASES          #
#                            #
##############################

alias cdtrash='cd ~/Trash'
alias cltrash='rm ~/Trash/* -rf'

cdp()
{
    cd ~/Project 2>/dev/null
    if [ $# -eq 0 ]; then
        cd $CURRENT_PROJECT 2>/dev/null
        if [ $? -gt 0 ]; then
            echo -e "\e[31mDefault project \e[33m\`$CURRENT_PROJECT'\e[31m does not exist, plese create it first\e[0m"
            return 1
        fi
    else 
        cd $1* 2>/dev/null
        if [ $? -gt 0 ]; then
            echo -e "\e[33mFirst Argument does not match an existing project, using project \e[32m\`$CURRENT_PROJECT'\e[33m instead\e[0m"
            cd $CURRENT_PROJECT 2>/dev/null
            if [ $? -gt 0 ]; then
                echo -e "\e[31mDefault project \e[33m\`$CURRENT_PROJECT'\e[31m does not exist, plese create it first\e[0m"
                return 1
            fi
            cd $1* 2>/dev/null
        fi
    fi

    shift
    if [ $# -gt 0 ]; then
        for i in $@; do
            cd $i* 2>/dev/null
        done
    fi
}

function cdd()
{
    cd ~/Perso
    for i in $@; do
        cd $i*
    done
}

function cdc()
{
    cd ~/Config
    for i in $@; do
        cd $i*
    done
}

function up( )
{
    if [ $# -eq 0 ]; then
        LIMIT=1
    else
        LIMIT=$1
    fi
    P=$PWD
    for ((i=1; i <= LIMIT; i++))
    do
        P=$P/..
    done
    cd $P
    export MPWD=$P
}

function back()
{
    if [ $# -eq 0 ]; then
        LIMIT=1
    else
        LIMIT=$1
    fi
    P=$MPWD
    for ((i=1; i <= LIMIT; i++))
    do
        P=${P%/..}
    done
    cd $P
    export MPWD=$P
}

##############################
#                            #
#            MISC.           #
#                            #
##############################

alias turtle="echo -e \"Do \e[4;1;31mNOT\e[0m touch the \e[1;5;4;31mTurtle\""
CAPSON()
{
    if [ `COLS` -gt 150 ]; then
        cat ~/Config/other/ascii/CAPSONCAPSOFF
    else
        echo CAPS LOCK CONNARD !
    fi
}
alias caps='echo -e -n "\e[1;5;31m" ;CAPSON ;echo -e -n "\n\e[0m\n"'

alias LS='caps;ls'
alias SL='caps;sl'
alias sl='cl; echo -e "\e[31;1m3"; sleep 1; cl; echo 2; sleep 1; cl; echo 1; sleep 1; echo -e "\e[0m"; sl; cl'
alias CD='caps;cd'
alias VIM='caps;vim'
alias TREE='caps;tree'
alias LA='caps;la'
alias RM='caps;rm'
alias CL='caps;cl'
alias CDP='caps;cdp'

alias emacs='echo non'

alias paint='echo kryta'
alias sound='echo pavucontrol'

alias excuse='~/Config/bin/scripts/excuse.sh'

##############################
#                            #
#        QUICK ACCESS        #
#                            #
##############################

# HAHAHAHAHAHAHAHAHA
alias gcc='gcc -Werror -Wall -Wextra -pedantic -std=c99'
# Just kidding
unalias gcc
# Now for real
alias gcc='perl ~/Config/bin/scripts/colorgcc.perl'

alias LINES='tput lines'
alias COLS='tput cols'

alias vsh='vim ~/.shellrc.sh; srcsh'
alias esh='vim ~/.export.sh'

alias cl='clear'
alias l='ls'
alias j='jogsoul'
alias subl='subl3'

alias cdtiger="cd $TIGER_DIR"
alias untpile="rm -rf $TIGER_DIR"
alias ftpile="untpile;tpile"

alias wifi-menu="sudo wifi-menu"

alias sql='~/Config/bin/scripts/postgres.sh'
alias valgrind='~/Config/bin/scripts/valgrind-color.sh'
alias const='~/Config/bin/tools/getconstructor.sh'
alias tpile=". ~/Config/bin/scripts/compile_tiger.sh"

alias ratp='~/Config/bin/scripts/ratp.sh'
alias rmswp='rm `find . | grep -E "^\..*\.sw[pon]$"`'
alias gdb='gdb -q'
alias python3="python3 -q"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -a'
alias ll='ls -l' 
alias lll='~/Config/bin/tools/ll.sh'
alias lla='ls -a -l'
alias tree='tree -C'
alias vlgless='valgrind'
alias vlg='valgrind --leak-check=full --show-reachable=yes'
alias vlfull='valgrind --leak-check=full -v --show-reachable=yes'

man() {
    # Respectively
    #   Never saw it used in man page
    #   Title, options.
    #   Text in option
    #   Don't touch probably important that it is 0
    #   Test Bottom page
    #   ]
    #   EXPRESSION
    env LESS_TERMCAP_mb=$'\E[5;01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;202m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;45m' \
        man "$@"
}


##############################
#                            #
#            TOOLS           #
#                            #
##############################

function resetadb()
{
    adb kill-server
    sudo adb start-server
    adb devices
}

alias password="~/Config/confloose/anti/password.sh"
#Search a motif into all file in subdirectory
alias grepc="~/Config/bin/tools/grepc.sh"
alias fixme='grepc "(//\s*FIXME)|(--\s*FIXME)|(/\*\s*FIXME\s*\*/)|(#\s*FIXME)"'
#Search for a file
alias gfind="~/Config/bin/tools/gfind.sh"

alias mount='~/Config/bin/tools/mount.sh'
alias umount='~/Config/bin/tools/umount.sh'
# Check coding style
alias ccs='sh ~/Config/bin/scripts/checkcodingstyle.sh'
alias ccsprojekt='cl;ccs; ccs README TODO AUTHORS'
alias javacommitall="fun_commitall java"
alias commitall="fun_commitall"
alias autocommit="fun_commitall $SUPPORTED_EXTENTIONS"

function fun_commitall()
{
    if [ -f "./build.xml" ]; then
        git add build.xml
        git commit -m "Add build.xml"
    fi
    if [ -f "./Makefile" ]; then
        git add Makefile
        git commit -m "Add Makefile"
    fi
    for i in $@; do
        for i in `find src tests | grep -E "\.$i\$"`; do
            if [ -f $i ]; then
                git add $i
                git commit -m"Add `basename $i | sed -E "s/(.*)\.(.*)/\2 file : \1/g"`"
            fi
        done
    done
}

alias change=". ~/Config/bin/tools/change.sh"
alias ccp="change project"
alias ccb="change bdd"
alias revert="change revert"
alias verbose="change verbose"
alias debug="change debug"

function sedit()
{
    if [ $# -eq 1 ]; then
        alias $1 | grep -E "alias .*=('|\").*\.sh('|\")" >/dev/null 2>/dev/null
        if [ $? -eq 0 ]; then
            file=`alias $1 | grep -o -E "(\"|').*(\"|')"`
            file=`echo $file | sed "s/\('\|\"\)//g" | sed "s/^\. //g" | sed "s@~@$HOME@g"`
            if [ "$FLAG_DEBUG" != on ]; then
                vim $file
            fi
        else
            echo -e "\e[33;1m\`$1' is probably not an alias for a script\e[0m"
        fi
    else
        echo >&2 -e "\e[33;1mUsage: sedit alias_name\e[0m"
    fi
}


alias buildall='cd ~/Project; for i in `ls`; do echo -e "\e[34;1mBuilding Project: \e[0m\`\e[35;1m"$i"\e[0m\047" ; cd $i ; (make 2>/dev/null 1>/dev/null); cd ..; done'
alias cleanall='cd ~/Project; for i in `ls`; do echo -e "\e[34;1mCleaning Project: \e[0m\`\e[35;1m"$i"\e[0m\047" ; cd $i ; (make clean 2>/dev/null 1>/dev/null); cd ..; done'


extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.tar.xz)    tar xf $1      ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

log_output()
{
    if [ $# -gt 0 ]; then
        $@ 1>stdout_$1 2>stderr_$1
    else
        rm stderr_* stdout_* -i
    fi
}


mkcd()
{
    mkdir $@
    cd $@
}

cs()
{
    cd "$@";
    ls --color=auto;
}

##############################
#                            #
#        FILE CREATION       #
#                            #
##############################

alias todo="~/Config/bin/scripts/todo.sh"

# File.c & File.h :
new_dot_c()
{
    sh ~/Config/bin/tools/newc.sh $@
}

new_dot_h()
{
    sh ~/Config/bin/tools/newh.sh $@
}

# Makefile :
alias nmk='cp ~/Config/template/makefiles/Makefile Makefile'

# Fichier Script:
alias nsh='sh ~/Config/bin/tools/new.sh '

# Other File:
alias nTODO='cp ~/Config/template/other/TODO .'
alias nREADME='cp ~/Config/template/other/README .'
alias mkauth='> AUTHORS echo "* piriou_a";chmod 640 AUTHORS'
alias AUTHORS='> AUTHORS echo "* piriou_a";chmod 640 AUTHORS'
alias ngitignore='cp ~/Config/template/other/gitignore ./.gitignore'


##############################
#                            #
#             VIM            #
#                            #
##############################

alias vimrc='vim ~/.vimrc'
alias vimrt='vim -O README TODO'
alias vimm='\vim'
#Treats vim arguments to know which file to open
alias vim="~/Config/bin/tools/vim.sh"

##############################
#                            #
#             GIT            #
#                            #
##############################
alias lg1='log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'

if [ "$LOCATION" != "pxe" ]; then
    alias blame='git-fame'
else
    alias blame='~/Config/bin/scripts/gitblame.sh'
fi

howmanycommitbitch()
{
    a=$((`git shortlog | wc -l` - 2))
    if [ $a -gt 1 ]; then
        echo "You made $a commits bitch!"
    else
        echo "You made $a commit bitch!"
    fi
}

alias checkout='git checkout'
alias gdif='git diff'
alias gdiff='git diff'
alias commit='git commit -m'
alias status='git status'
alias add='git add'
alias log='git log'
alias slog='git shortlog'
alias branch='git branch'

alias submission='~/Config/bin/tools/pushtags.sh'
alias pushtags='~/Config/bin/tools/pushtags.sh'

alias gitpull='gpull'
gpull()
{
    if [ $# -eq 2 ]; then
        if [ $1 = "origin" ]; then
            git checkout $2
            git pull $@
        else
            echo -e -n "\e[33m"
            echo -n "I do not know how to switch in a branch not in origin yet,"
            echo -n " can't switch to $1/$2 use \`git checkout' and \`git pull' instead"
            echo -e "\e[0m"
        fi
    else
        git checkout master
        git pull origin master
    fi
}

alias gitpush='gpush'
gpush()
{
    if [ "$#" = "0" ]; then
        git push origin master;
    else
        git push $@;
    fi
}

alias mkrepo="~/Config/bin/scripts/mkrepo.sh"


##############################
#                            #
#           OTHERS           #
#                            #
##############################

# Config Save :
alias savebash='cp ~/.shellrc.sh ~/Config/rc/shellrc.sh'
alias getbash='cp ~/Config/rc/shellrc.sh ~/.shellrc.sh; srcsh'
alias savevimrc='cp ~/.vimrc ~/Config/rc/vimrc'
alias savei3Config='cp ~/.i3/config ~/Config/i3/config'

alias whatsnew='~/Config/bin/scripts/modifbash.sh notclean'
alias cleanwhatsnew='~/Config/bin/scripts/modifbash.sh clean'

gitsave()
{
    cd ~/Config
    add --all
    if [ $# -eq 0 ]; then
        git commit -m "Auto save message"
    else
        git commit -m "$@"
    fi
    git push origin master
}

gitsaveall()
{
    cp ~/.shellrc.sh ~/Config/rc/shellrc.sh
    cp ~/.vimrc ~/Config/rc/vimrc
    cp ~/.i3/config ~/Config/i3/config

    gitsave "$@"
}

# Stupid Things :
alias slowswapper='xmodmap ~/Config/x/slowswapper'
alias tsu='cat ~/Config/other/ascii/Tsu'


# YOU CAN'T KILL THE HUNGRY RABBIT
# Confloose : 
alias bunny2='sh ~/Config/confloose/bunny2.sh'
alias challenge="echo -e \"try to delete the file called \\\`\\e[32;1m?[0\e[0m\\\e[0m'\";touch $'\033'\[0; ls"
alias clearchallenge="rm $'\033'\[0"

##############################
#                            #
#       ENFORCE DEFAULT      #
#                            #
##############################

#xset r rate 250 50
source ~/Config/confloose/anti/fuckyou.sh
