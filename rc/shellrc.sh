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

# Contain most exports or configuration variable
source ~/.export.sh


# Since the same config file can be used across all your device, you can use
# this part to define specific aliases, for example here the number of core make
# shall use. The location shall be defined in .bashrc or .export.sh

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

# You can also use the same file for different Shell 
# example here : a somewhat okay configuration for bash
#                a bad one for zsh (sorry)).

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

# This directory is one I use for experiments, you can do things in it then
# erase it without worrying about where you were

alias cdtrash='cd ~/Trash'
alias cltrash='rm ~/Trash/* -rf'

cdp()
{
  cd $MAIN_PROJECT_DIR 2>/dev/null
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
  cd $CUSTOM_PROJECT_DIR
  for i in $@; do
    cd $i*
  done
}

function cdc()
{
  cd $CONFIG_GIT_DIR
  for i in $@; do
    cd $i*
  done
}

function up()
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

# Honnestly you should probably delete this whole section.
alias turtle="echo -e \"Do \e[4;1;31mNOT\e[0m touch the \e[1;5;4;31mTurtle\""

alias LS='ls'
# If you do not like that you should probably change it to ls
alias SL='sl'
alias CD='cd'
alias VIM='vim'
alias TREE='tree'
alias LA='la'
alias RM='rm'
alias CL='cl'
alias CDP='cdp'

# Let's start a flame war
alias emacs='echo "You should really use vim instead"; sleep 1; vim'

alias excuse="$CONFIG_GIT_DIR/bin/scripts/excuse.sh"

##############################
#                            #
#        QUICK ACCESS        #
#                            #
##############################

# HAHAHAHAHAHAHAHAHA
alias gcc='gcc -Werror -Wall -Wextra -pedantic -std=c99'
# Just kidding
unalias gcc
# Now for real, color gcc output
alias gcc="perl $CONFIG_OTHER_DIR/bin/scripts/colorgcc.perl"

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

alias sql="$CONFIG_GIT_DIR/bin/scripts/postgres.sh"
alias valgrind="$CONFIG_OTHER_DIR/bin/scripts/valgrind-color.sh"
alias const="$CONFIG_GIT_DIR/bin/tools/getconstructor.sh"
alias tpile=". $CONFIG_OTHER_DIR/bin/scripts/compile_tiger.sh"

# This script is used to get the next transport for me, you'll need to adapt it
alias ratp="$CONFIG_GIT_DIR/bin/scripts/ratp.sh"
alias rmswp='rm `find . | grep -E "^\..*\.sw[pon]$"`'

alias gdb='gdb -q'
alias python3="python3 -q"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -a'
alias ll='ls -l' 
alias lla='ls -a -l'
alias tree='tree -C'
alias vlgless='valgrind'
alias vlg='valgrind --leak-check=full --show-reachable=yes'
alias vlfull='valgrind --leak-check=full -v --show-reachable=yes'

# Color the output of man
man() {
  #   Respectively
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

# Dirty trick because I haven't configure it properly yet
function resetadb()
{
  adb kill-server
  sudo adb start-server
  adb devices
}

# A very weak (very very weak) password protection for some scripts
# DO NOT USE FOR ANYTHING REMOTLY IMPORTANT
# DO NOT USE YOUR ROOT PASSWORD FOR THIS
alias password="$CONFIG_GIT_DIR/bin/tools/password.sh"

# Search a motif into all file in subdirectory (Can be long if there is a lot of
# files)
alias grepc="$CONFIG_GIT_DIR/bin/tools/grepc.sh"
alias fixme='grepc "(//\s*FIXME)|(--\s*FIXME)|(/\*\s*FIXME\s*\*/)|(#\s*FIXME)"'

# Search for a file (Can be long if there is a lot of subdirectory)
alias gfind="$CONFIG_GIT_DIR/bin/tools/gfind.sh"

# This is for my convenience, you might need to change them for your use
alias mount="$CONFIG_GIT_DIR/bin/tools/mount.sh"
alias umount="$CONFIG_GIT_DIR/bin/tools/umount.sh"

# Check coding style, it's highly probable you don't need the next two
# just delete them
alias ccs="sh $CONFIG_GIT_DIR/bin/scripts/checkcodingstyle.sh"
alias ccsprojekt='cl;ccs; ccs README TODO AUTHORS'


# Those aliases commit all file matching an extention in subdirectory
# Be carefull when you use it. 
# I mean don't use it, it defeats the purpose of version control.
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
    for i in `find . | grep -E "\.$i\$"`; do
      if [ -f $i ]; then
        git add $i
        git commit -m"Add `basename $i | sed -E "s/(.*)\.(.*)/\2 file : \1/g"`"
      fi
    done
  done
}

# Change script, very usefull, you should check it out
alias change=". $CONFIG_GIT_DIR/bin/tools/change.sh"
alias ccp="change project"
alias ccb="change bdd"
alias revert="change revert"
alias verbose="change verbose"
alias debug="change debug"
function cpr()
{
  if [ $# -ne 2 ]; then
    echo >&2 -e "\e[32;1m$0: Copy and rename files"
    echo >&2 -e "\e[32;1mUsage: $0 [OLDNAME.] [NEWNAME.]"
  fi
  OLDNAME=`echo $1 | sed "s/\.$//g"`
  NEWNAME=`echo $2 | sed "s/\.$//g"`
  for i in $OLDNAME.*; do
    cp $i `echo $i | sed "s/$OLDNAME/$NEWNAME/g"`
  done
}
function sedit()
{
  if [ $# -eq 1 ]; then
    alias $1 | grep -E "alias .*=('|\").*\.(sh|py)('|\")" >/dev/null 2>/dev/null
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

# This one isn't from me, I picked it up on internet
# and I've been unable to track the original author
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

# Create a directory and cd inside
mkcd()
{
  mkdir $@
  cd $@
}

# Cd inside a directory and display its content
# You might want to use it as your default cd behaviour, i'm not a fan
# alias cd="cs"
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

alias todo="$CONFIG_GIT_DIR/bin/scripts/todo.py"

# Makefile :
alias nmk="cp $CONFIG_GIT_DIR/template/makefiles/Makefile Makefile"

# Other File:
alias nTODO="cp $CONFIG_GIT_DIR/template/other/TODO ."
alias nREADME="cp $CONFIG_GIT_DIR/template/other/README ."
alias nAUTHORS='AUTHORS'
alias AUTHORS='> AUTHORS echo "* piriou_a";chmod 640 AUTHORS'
alias ngitignore="cp $CONFIG_GIT_DIR/template/other/gitignore ./.gitignore"


##############################
#                            #
#             VIM            #
#                            #
##############################

alias vimrc='vim ~/.vimrc'
alias vimrt='vim -O README TODO'
alias vimm='\vim'
#Treats vim arguments to know which file to open
alias vim="$CONFIG_GIT_DIR/bin/tools/vim.sh"

##############################
#                            #
#             GIT            #
#                            #
##############################
# An awesome one liner I picked up on internet to display a git repo with its
# branch
alias lg1='log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'

if [ "$LOCATION" != "pxe" ]; then
  # Ruby gem script, display work distribution
  alias blame='git-fame'
fi

# I do not have an explanation for this one
howmanycommitbitch()
{
  sum=0
  for i in `git shortlog | grep -E  ".* \([0-9]+\):" | grep -o -E "[0-9]+"`; do
    sum=$(($sum + $i))
  done
  if [ $sum -gt 1 ]; then
    echo "You made $sum commits bitch!"
  else
    echo "You made $sum commit bitch!"
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

alias pushtags="submission"
alias submission="$CONFIG_GIT_DIR/bin/tools/pushtags.sh"

alias gitpull='gpull'
gpull()
{
  if [ $# -eq 2 ]; then
      git checkout $2
      git pull $@
  elif [ $# -eq 1 ]; then
    git checkout master
    git pull $1 master
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

alias mkrepo="$CONFIG_GIT_DIR/bin/scripts/mkrepo.sh"

function swapauthorgit()
{
  echo -e -n "\e[32;1mUsing this function is dangerous and will rewrite your"
  echo -e -n " entire commit history, do you wish to proceed (Y/n): \e[0m"
  read -r CHOICE
  CHOICE=`echo "$CHOICE" | tr '[:upper:]' '[:lower:]'`
  if [ -z "$CHOICE" ] || [ "$CHOICE" = "y" ] || [ "$CHOICE" = "yes" ]; then
    echo -e -n "\e[36;1mWhat's the old name of the commiter: \e[0m"
    read -r OLD_NAME
    echo -e -n "\e[36;1mWhat's the old email of the commiter: \e[0m"
    read -r OLD_EMAIL
    echo -e -n "\e[36;1mWhat's the new author's name: \e[0m"
    read -r NEW_NAME
    echo -e -n "\e[36;1mWhat's the new author's email: \e[0m"
    read -r NEW_EMAIL
    echo -e -n "\e[32;1mYou're about to replace all commit of $OLD_NAME"
    echo -e -n " ($OLD_EMAIL) by $NEW_NAME ($NEW_EMAIL), do you wish"
    echo -e -n " to proceed (y/N): \e[0m"
    read -r CHOICE
    CHOICE=`echo "$CHOICE" | tr '[:upper:]' '[:lower:]'`
    if [ "$CHOICE" = "y" ] || [ "$CHOICE" = "yes" ]; then
      git filter-branch -f --env-filter "GIT_AUTHOR_NAME=$NEW_NAME; GIT_AUTHOR_EMAIL=$NEW_EMAIL; GIT_COMMITTER_NAME=$OLD_NAME; GIT_COMMITTER_EMAIL=$OLD_EMAIL;" HEAD
    fi
  fi
}

##############################
#                            #
#           OTHERS           #
#                            #
##############################

# Config Save :
getconfig()
{
  if [ $# -eq 0 ]; then
    cp $CONFIG_GIT_DIR/i3/config ~/.i3/config
    cp $CONFIG_GIT_DIR/i3/i3status.conf ~/.i3status.conf
    cp $CONFIG_GIT_DIR/rc/shellrc.sh ~/.shellrc.sh
    cp $CONFIG_GIT_DIR/rc/bashrc ~/.bashrc
    cp $CONFIG_GIT_DIR/vim/vimrc ~/.vimrc
    cp $CONFIG_GIT_DIR/X/Xdefaults ~/.Xdefaults
  else
    while [ $# -ne 0 ]; do
      case $1 in
        i3)
          cp $CONFIG_GIT_DIR/i3/config ~/.i3/config
          cp $CONFIG_GIT_DIR/i3/i3status.conf ~/.i3status.conf
          ;;
        bash)
          cp $CONFIG_GIT_DIR/rc/shellrc.sh ~/.shellrc.sh
          cp $CONFIG_GIT_DIR/rc/bashrc ~/.bashrc
          ;;
        vim)
          cp $CONFIG_GIT_DIR/vim/vimrc ~/.vimrc
          ;;
        X)
          cp $CONFIG_GIT_DIR/X/Xdefaults ~/.Xdefaults
          ;;
        all)
          cp $CONFIG_GIT_DIR/i3/config ~/.i3/config
          cp $CONFIG_GIT_DIR/i3/i3status.conf ~/.i3status.conf
          cp $CONFIG_GIT_DIR/rc/shellrc.sh ~/.shellrc.sh
          cp $CONFIG_GIT_DIR/rc/bashrc ~/.bashrc
          cp $CONFIG_GIT_DIR/vim/vimrc ~/.vimrc
          cp $CONFIG_GIT_DIR/X/Xdefaults ~/.Xdefaults
          ;;
      esac
      shift
    done
  fi
}

saveconfig()
{
  if [ $# -eq 0 ]; then
    cp ~/.i3/config     $CONFIG_GIT_DIR/i3/config
    cp ~/.i3status.conf $CONFIG_GIT_DIR/i3/i3status.conf
    cp ~/.shellrc.sh    $CONFIG_GIT_DIR/rc/shellrc.sh
    cp ~/.bashrc        $CONFIG_GIT_DIR/rc/bashrc
    cp ~/.vimrc         $CONFIG_GIT_DIR/vim/vimrc
    cp ~/.Xdefaults     $CONFIG_GIT_DIR/X/Xdefaults
  else
    while [ $# -ne 0 ]; do
      case $1 in
        i3)
          cp ~/.i3/config     $CONFIG_GIT_DIR/i3/config
          cp ~/.i3status.conf $CONFIG_GIT_DIR/i3/i3status.conf
          ;;
        bash)
          cp ~/.shellrc.sh    $CONFIG_GIT_DIR/rc/shellrc.sh
          cp ~/.bashrc        $CONFIG_GIT_DIR/rc/bashrc
          ;;
        vim)
          cp ~/.vimrc         $CONFIG_GIT_DIR/vim/vimrc
          ;;
        X)
          cp ~/.Xdefaults     $CONFIG_GIT_DIR/X/Xdefaults
          ;;
        all)
          cp ~/.i3/config     $CONFIG_GIT_DIR/i3/config
          cp ~/.i3status.conf $CONFIG_GIT_DIR/i3/i3status.conf
          cp ~/.shellrc.sh    $CONFIG_GIT_DIR/rc/shellrc.sh
          cp ~/.bashrc        $CONFIG_GIT_DIR/rc/bashrc
          cp ~/.vimrc         $CONFIG_GIT_DIR/vim/vimrc
          cp ~/.Xdefaults     $CONFIG_GIT_DIR/X/Xdefaults
          ;;
      esac
      shift
    done
  fi
}

alias getbash='getconfig bash; srcsh'
alias savebash='saveconfig bash'

alias whatsnew="$CONFIG_GIT_DIR/bin/scripts/modifbash.sh notclean"
alias cleanwhatsnew="$CONFIG_GIT_DIR/bin/scripts/modifbash.sh clean"

##############################
#                            #
#       ENFORCE DEFAULT      #
#                            #
##############################

#xset r rate 250 50
source $CONFIG_GIT_DIR/bin/tools/fuckyou.sh
