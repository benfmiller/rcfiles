#!/bin/sh


if [ `whoami` != 'root' ]
  then
    echo "copying config"
    cp ~/rcfiles/tmux_sourcer.conf ~/.tmux.conf
    cp ~/rcfiles/vimrc_sourcer.vim ~/.vimrc
    cp ~/rcfiles/zshrc_sourcer.sh ~/.zshrc
    echo "If ran as root, also installs fzf and ripgrep"
else
    echo "copying config"
    cp /home/$SUDO_USER/rcfiles/tmux_sourcer.conf ~/.tmux.conf
    cp /home/$SUDO_USER/rcfiles/vimrc_sourcer.vim ~/.vimrc
    cp /home/$SUDO_USER/rcfiles/zshrc_sourcer.sh ~/.zshrc
    echo "Installing fzf and ripgrep"
    sudo apt install fzf ripgrep
    exit
fi

tmux source-file ~/.tmux.conf
echo "All Good!"
zsh
