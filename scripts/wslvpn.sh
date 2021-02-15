#!/bin/sh

NEW_HOME= find /home -maxdepth 2 -type d -name rcfiles
echo $NEW_HOME\b/../
return 1

if [ `whoami` = 'root' ]
  then

    echo "Moving old config files to ~/.config/old_config"
    mkdir /home/$USER/.config/old_config
    if test -f "/home/$USER/.vimrc"; then
        mv /home/$USER/.vimrc /home/$USER/.config/old_config/
    fi
    if test -f "/home/$USER/.zshrc"; then
        mv /home/$USER/.zshrc /home/$USER/.config/old_config/
    fi
    if test -f "/home/$USER/.tmux.conf"; then
        mv /home/$USER/.tmux.conf /home/$USER/.config/old_config/
    fi

    echo "copying config"
    cp /home/$USER/rcfiles/tmux/tmux_sourcer.conf /home/$USER/.tmux.conf
    cp /home/$USER/rcfiles/vim/vimrc_sourcer.vim /home/$USER/.vimrc
    cp /home/$USER/rcfiles/zsh/zshrc_sourcer.sh /home/$USER/.zshrc
    echo "Installing fzf and ripgrep"
    sudo apt install fzf ripgrep
    exit

else
    echo "Must use sudo"
    return 1
fi

# tmux source-file ~/.tmux.conf
# echo "All Good!"
# zsh
