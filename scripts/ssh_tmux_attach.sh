#!/usr/bin/env bash

session=$(tmux display-message -p "#S")

echo "$session"

REMOTE_WS=$(ssh dev tmux ls)


if [[ $(echo "$REMOTE_WS" | rg "$session") ]]; then
    echo "Found $session on remote. Attaching"
    ssh dev tmux -2 attach -d -t $session
else
    echo "Did not find $session on remote. Creating"
    ssh dev tmux -2 new-session -s $session
fi
