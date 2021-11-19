#!/usr/bin/env bash
languages=`echo "golang flutter nodejs javascript typescript cpp c lua rust python bash php haskell css html sql" | tr ' ' '\n'`
core_utils=`echo "git xargs find mv sed awk" | tr ' ' '\n'`

selected=`printf "$languages\n$core_utils" | fzf`
if [[ -z $selected ]]; then
    read -p "Enter Topic: " selected
fi
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query
query=`echo $query | tr ' ' '+'`

tmux neww bash -c "echo \"curl cht.sh/$selected/$query\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
