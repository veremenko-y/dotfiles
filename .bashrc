#
# ~/.bashrc
#

#
# Defaults from the installation
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#source /usr/share/blesh/ble.sh --noattach
PS1='[\u@\h \W]\$ '
#export PS1="\e[0;32m[\u@\h \W]\$ \e[m"

# My config
# ---------
if [ "$SYSTEM" == "Darwin" ]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
    HOSTNAME=$(hostname -s | sed 's/'$(whoami)'-//')
else
    HOSTNAME=$(hostnamectl hostname --pretty)
    alias la='ls -la --group-directories-first'
fi

#
# History settings
# ----------------

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
export HISTFILE=$HOME/.bash_history
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTTIMEFORMAT="%y-%m-%d %T "

#
# Prompt settings
#

# Load all bash completions
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f /opt/brew/etc/profile.d/bash_completion.sh ]; then
    . /opt/brew/etc/profile.d/bash_completion.sh
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

[ -f ~/.config/shell/aliases ] && source ~/.config/shell/aliases

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
DIRCOLOR=~/.config/bash/dircolors
test -r $DIRCOLOR && eval "$(dircolors -b $DIRCOLOR)" || eval "$(dircolors -b)"

# Less configuration
# ------------------

# Enable color output. Also enables lesspipe colorizer.
# lesspipe manpage states not to us `-r` option as it could
# result in the wrong screen layout.

# To turn syntax highlighting off, append colon (:) to the file name

alias less='less -R'
# New cofiguration
if [ type -p lesspipe.sh ]; then
    LESSOPEN="|/usr/bin/lesspipe.sh %s"
    export LESSOPEN
    LESSCOLORIZER='source-highlight'
    export LESSCOLORIZER
fi
# ------

# Powerline Prompt 
# ----------------
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

if [ type -p powerline-daemon ]; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    . /usr/share/powerline/bindings/bash/powerline.sh
fi

# FZF Key bindings
# ------------
_ble_contrib_fzf_base=/usr/share/fzf
if [[ ${BLE_VERSION-} ]]; then
  ble-import -d integration/fzf-key-bindings
else
  source /usr/share/fzf/key-bindings.bash
fi

# Add this line at the end of .bashrc:
[[ ${BLE_VERSION-} ]] && ble-attach

