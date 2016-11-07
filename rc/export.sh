##############################
#                            #
#        CONFIGURATION       #
#                            #
##############################

# Directory to store scripts and config file. Can be accessed with the `cdc'
# alias
export CONFIG_GIT_DIR="$HOME/Config"

# Directory used to store scripts and config file (this directory does not use
# version control and is used for scripts I didn't write)
export CONFIG_OTHER_DIR="$HOME/Config/rsrc"

# Directory for all your project. Can be accessed with the `cdp' alias
export MAIN_PROJECT_DIR="$HOME/Project"

# Directory for all your project. Can be accessed with the `cdd' alias
export CUSTOM_PROJECT_DIR="$HOME/Perso"

# Directory for all your work project. Can be accessed with the `cde' alias
export CUSTOM_WORK_DIR="$HOME/Work"

##############################
#                            #
#     CHANGEABLE EXPORTS     #
#                            #
##############################

export EDITOR="vim"

export FLAG_DEBUG="off"
export FLAG_VERBOSE="off"

export SUPPORTED_EXTENTIONS="py sql ll yy sh hxx hh cc h c java"
export PRIORITY_PICKS="hxx cc hh"

export CURRENT_PROJECT="YAKASTING"
export TIGER_DIR="/tmp/tiger"
export CURRENT_BDD="samedi_matin"


##############################
#                            #
#        OTHER EXPORTS       #
#                            #
##############################

export NNTPSERVER="news.epita.fr"
export LOCK="~/.my_bin/epi3lock"
size=`xrandr | grep -E "\*" | grep -E -o "[0-9]+x[0-9]+" | head -n 1`
if [ -d "$HOME/Pictures/Wallpaper/$size" ]; then
    export LOCKSCREEN="$HOME/Pictures/Wallpaper/$size/hal9000.png"
else
    export LOCKSCREEN=""
fi
export WALLPAPER="$HOME/Pictures/Wallpaper/mickey.png"
export DEADLOCK="false"
