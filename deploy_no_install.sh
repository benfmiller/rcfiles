#!/bin/sh


if [ `whoami` != 'root' ]
  then
    echo "copying config"
    cp ~/rcfiles/tmux_sourcer.conf ~/.tmux.conf
    cp ~/rcfiles/vimrc_noinstall_sourcer.vim ~/.vimrc
    cp ~/rcfiles/zshrc_noinstall_sourcer.sh ~/.zshrc
else
    echo "Don't use as root!"
    return 1
fi

tmux source-file ~/.tmux.conf
echo "All Good!"
zsh
