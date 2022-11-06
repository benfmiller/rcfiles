#!/usr/bin/env bash

open_sessions=$(tmux -2 ls | cut -f1 -d":")

# pulls out "learning" bounded by whitespace
open_sessions=$(echo "$open_sessions" | grep -v -E '(^| )learning( |$)')
open_sessions="learning\n$open_sessions"

# -e parses \n as new line
selected=$(echo -e "$open_sessions"| fzf)

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(echo $selected | cut -f1 -d" ")

tmux_running=$(pgrep tmux)
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t $selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi
if [[ -z $TMUX ]]; then
    tmux attach-session -t $selected_name
else
    tmux switch-client -t $selected_name
fi
