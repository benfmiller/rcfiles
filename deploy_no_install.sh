#!/bin/sh


if [ `whoami` != 'root' ]
  then
    echo "copying config"
    cp ~/rcfiles/tmux_sourcer.conf ~/.tmux.conf
    cp ~/rcfiles/vimrc_noinstall_sourcer.vim ~/.vimrc
    cp ~/rcfiles/zshrc_noinstall_sourcer.sh ~/.zshrc
    echo "If ran as root, also installs fzf and ripgrep"
else
    echo "Don't use as root, but it still worked"
    cp /home/$SUDO_USER/rcfiles/tmux_sourcer.conf ~/.tmux.conf
    cp /home/$SUDO_USER/rcfiles/vimrc_noinstall_sourcer.vim ~/.vimrc
    cp /home/$SUDO_USER/rcfiles/zshrc_noinstall_sourcer.sh ~/.zshrc
    exit
fi

tmux source-file ~/.tmux.conf
echo "All Good!"
zsh
