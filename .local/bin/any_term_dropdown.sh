#!/usr/bin/env bash
# AUTHOR: gotbletu (@gmail|twitter|youtube|github|lbry)
#         https://www.youtube.com/user/gotbletu
# MODIFIED: yaros
# DESC:   turn any terminal into a dropdown terminal
# DEMO:   https://www.youtube.com/watch?v=mVw2gD9iiOg
# DEPEND: coreutils xdotool
# CLOG:   2024-03-01   use xdotool only, removed wmutils dependency
#         2022-03-05   else statement to allow terminal to jump to current virtual desktop if is visible on another desktop
#         2022-02-28   added auto launch terminal if none running by https://github.com/aaccioly
#         2021-02-10   use comm to match window name and class, this avoids terminal windows with different names
#         2015-02-15   0.1

# option 1: set terminal emulator manually
# my_term=urxvt
# my_term=sakura
# my_term="xterm"
# my_term="alacritty"
# my_term=terminator
# my_term=gnome-terminal
my_term=kitty # for kitty to work uncomment line 30 and comment line 33
#my_term=gnome-terminal

# option 2: auto detect terminal emulator (note: make sure to only open one)
# my_term="urxvt|kitty|xterm|uxterm|termite|sakura|lxterminal|terminator|mate-terminal|pantheon-terminal|konsole|gnome-terminal|xfce4-terminal"

# get terminal emulator pid ex: 44040485
pid=$(xdotool search --class "$my_term" | tail -n1)

ppid=$(xdotool getwindowpid "$pid" | tail -n1)

# get terminal emulator and matching name pid ex: 44040485
# pid=$(comm -12 <(xdotool search --name "$my_term" | sort) <(xdotool search --class "$my_term" | sort))

# start a new terminal if none is currently running
if [[ -z "$pid" ]]; then
    while IFS='|' read -ra TERMS; do
        for candidate_term in "${TERMS[@]}"; do
            if command -v "$candidate_term" &>/dev/null; then
                ${candidate_term} &>/dev/null &
                disown
                pid=$!
                break
            fi
        done
    done <<<"$my_term"
else
    # get windows id from pid ex: 0x2a00125%
    wid=$(printf 0x%x "$pid")

    # This did not work
    # wmctrl -v -r -i "$ppid" -b toggle,minimized
    # This did not work either
    # xdotool getwindowfocus
    state=$(xprop -id "$pid" | grep "_NET_WM_STATE(ATOM)")
    if [[ $state == *"FOCUSED"* ]]; then
        xdotool windowminimize "$pid"
    else
        xdotool windowactivate "$pid"
        xdotool windowraise "$pid"
        xdotool windowfocus "$pid"
    fi
fi
