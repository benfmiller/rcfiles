#!/bin/sh


if [ `whoami` = 'root' ]
  then
    echo "Don't use sudo!"
    return 1

    echo "Moving old config files to ~/.config/old_config"
    mkdir /home/$SUDO_USER/.config/old_config
    if test -f "/home/$SUDO_USER/.vimrc"; then
        mv /home/$SUDO_USER/.vimrc /home/$SUDO_USER/.config/old_config/
    fi
    if test -f "/home/$SUDO_USER/.zshrc"; then
        mv /home/$SUDO_USER/.zshrc /home/$SUDO_USER/.config/old_config/
    fi
    if test -f "/home/$SUDO_USER/.tmux.conf"; then
        mv /home/$SUDO_USER/.tmux.conf /home/$SUDO_USER/.config/old_config/
    fi

    echo "copying config"
    cp /home/$SUDO_USER/rcfiles/tmux/tmux_sourcer.conf /home/$SUDO_USER/.tmux.conf
    cp /home/$SUDO_USER/rcfiles/vim/vimrc_sourcer.vim /home/$SUDO_USER/.vimrc
    cp /home/$SUDO_USER/rcfiles/zsh/zshrc_sourcer.sh /home/$SUDO_USER/.zshrc
    echo "Installing fzf and ripgrep"
    sudo apt install fzf ripgrep
    exit

else
    echo "Moving old config files to ~/.config/old_config"
    mkdir ~/.config/old_config
    if test -f "~/.vimrc"; then
        mv ~/.vimrc ~/.config/old_config/.vimrc
    fi
    if test -f "~/.zshrc"; then
        mv ~/.zshrc ~/.config/old_config/.zshrc
    fi
    if test -f "~/.tmux.conf"; then
        mv ~/.tmux.conf ~/.config/old_config/.tmux.conf
    fi

    echo "copying config"
    cp ~/rcfiles/tmux/tmux_sourcer.conf ~/.tmux.conf
    cp ~/rcfiles/vim/vimrc_sourcer.vim ~/.vimrc
    cp ~/rcfiles/zsh/zshrc_sourcer.sh ~/.zshrc
    echo "If ran as root, also installs fzf and ripgrep"
fi

tmux source-file ~/.tmux.conf
echo "All Good!"
zsh
