#!/bin/sh

alias setxkbmap="_setxkbmap"

function _setxkbmap()
{
    if [ $# -eq 0 ]; then
        \setxkbmap fr
        return
    fi
    if [ $# -eq 1 ] && [ "$1" = "fr" ]; then
        \setxkbmap fr
    else
        password
        if [ $? -eq 0 ]; then
            \setxkbmap $@
        fi        
    fi
}
