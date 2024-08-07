#!/bin/bash
#echo "/usr/bin/lesspipe.sh "$@" | /usr/bin/less"
LESSOPEN="|/usr/bin/lesspipe.sh %s"
export LESSOPEN
LESSCOLORIZER='source-highlight'
export LESSCOLORIZER
/usr/bin/lesspipe.sh "$@" | less -RN
read -p "Press any key to resume ..."
