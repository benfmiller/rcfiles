#!/usr/bin/env bash
read -p "Enter Command: " query

# tmux neww bash -cl --rcfile "~/rcfiles/zsh/zsh_user.sh" "echo \"$query\" && \"$query\"; while [ : ]; do sleep 1; done"
# tmux neww bash -cl "echo \"$query\" && bash -cl ~/rcfiles/zsh/zsh_user.sh; \"$query\"; while [ : ]; do sleep 1; done"
tmux neww bash -c "echo \"$query\" && bash -cl \"$query\"; while [ : ]; do sleep 1; done"
