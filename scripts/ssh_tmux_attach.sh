#!/usr/bin/env bash

session=$(tmux display-message -p "#S")

echo "$session"

ssh dev tmux -2 attach -d -t $session
