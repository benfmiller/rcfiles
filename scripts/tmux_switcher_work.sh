#!/usr/bin/env bash

if [ -z $(uname | grep -v Darwin) ]; then
    dir_list=$(gfind $HOME/Work/ -maxdepth 2 -mindepth 1 -type d -printf '%p\n' )
else
    dir_list=$(find -L $HOME/Work/ -maxdepth 2 -mindepth 1 -type d -printf '%p\n' )
fi

# This keeps parent folder in there
# selected=$(echo $selected | tr ' ' '\n' | cut -f5- -d"/" | tr '/' '-')

# This gets childest folder
selected=$(echo $dir_list | tr ' ' '\n' | rev | cut -f1 -d"/" | rev)
selected=$selected\ learning

selected=$(echo $selected | tr ' ' '\n' | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

directory=$(echo "$dir_list" | grep "$selected$")
selected_name=$(echo $selected | cut -f1 -d" ")

tmux_running=$(pgrep tmux)
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    # tmux new-session -s $selected_name -c $selected
    tmux new-session -s $selected_name -c $directory
    exit 0
fi

if ! tmux has-session -t $selected_name 2> /dev/null; then
    # tmux new-session -ds $selected_name -c $selected
    tmux new-session -ds $selected_name -c $directory
fi
if [[ -z $TMUX ]]; then
    tmux attach-session -t $selected_name
else
    tmux switch-client -t $selected_name
fi
