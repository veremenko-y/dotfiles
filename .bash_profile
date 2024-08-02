#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# default apps
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

# bin path
export PATH="$PATH:/home/yaroslav/.local/share/go/bin:/home/yaroslav/.local/bin"

export LC_ALL=en_US.UTF-8

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export HISTFILE="~/.bash_history"
export ZDOTDIR="$HOME/.config/zsh"
export MANPAGER="less -R --use-color -Dd+r -Du+b"

export PICO_SDK_PATH="/home/yaroslav/doclocal/pico-sdk/"
