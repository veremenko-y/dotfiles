#
# ~/.bashrc
#

#
# Defaults from the installation
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '
#export PS1="\e[0;32m[\u@\h \W]\$ \e[m"

# =========
# My config
# =========

#
# History settings
#
# Stuff concerning Bash's command history
shopt -s histverify

# Append new history lines from each Bash session to $HISTFILE when the shell exits,
# rather than overwriting the file with the history list.  When histappend is unset,
# running several instances of Bash at the same time will result in the new history lines
# of all but the last instance that exits to be lost.  Having histappend unset also may
# pose an additional risk of losing (part of) the history if something goes wrong while
# overwriting the file.  See bash(1) and <https://unix.stackexchange.com/a/6509>.
shopt -s histappend
export HISTCONTROL=ignoreboth
#PROMPT_COMMAND="history -a; history -n"
export HISTFILE=$HOME/.bash_history
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTTIMEFORMAT="%y-%m-%d %T "

#
# Prompt settings
#
#PROMPT_COMMAND='echo -en "\e]0;$(dirs)\a"'  
#PROMPT_COMMAND="history -a; history -n;$PROMPT_COMMAND" # append history, read history

# Load all bash completions
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#
# Display and color settings
#
#TERM="screen-256color" # set terminal to 256, as well as force tmux to use 256 colors
TERM="xterm"
force_color_prompt=yes
shopt -s checkwinsize # always check windows size
export PATH="/home/yaroslav/.local/bin:$PATH"

. ~/.config/shell/aliases

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
DIRCOLOR=~/.config/bash/dircolors
test -r $DIRCOLOR && eval "$(dircolors -b $DIRCOLOR)" || eval "$(dircolors -b)"

#
# Less configuration
#

# Enable color output. Also enables lesspipe colorizer.
# lesspipe manpage states not to us `-r` option as it could
# result in the wrong screen layout.

# To turn syntax highlighting off, append colon (:) to the file name

alias less='less -R'
#export LESS='eFRX' ## does not work with pipes
#export LESS='R --mouse --wheel-lines=3'
# Enable lesspipe filter
# ------
# Old configuration backup
# ------
#export LESSOPEN='|lesspipe.sh %s'
#export LESSCOLORIZER='vimcolor' # it's not for nvim colors
#lessc () { /usr/share/nvim/runtime/macros/less.sh "$@"; }
# ------
# New cofiguration
LESSOPEN="|/usr/bin/lesspipe.sh %s"
export LESSOPEN
LESSCOLORIZER='source-highlight'
export LESSCOLORIZER
# ------

#
# FZF script
# 
. /usr/share/fzf/key-bindings.bash

#
# OneDark prompt
#
#. ~/.config/bash/onedark_prompt.sh

source /usr/share/nvm/init-nvm.sh

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

