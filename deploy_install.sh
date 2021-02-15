#!/bin/sh

# echo "$(dirname "$0")" ; echo "$(basename "$0")"
# export NEW_PATH=realpath "$(dirname "$0")"

if [ `whoami` = 'root' ]
  then
    echo "Don't use root!"
    return 1
    echo "Installing fzf and ripgrep"
    sudo apt install fzf ripgrep

    echo "Moving old config files to $ORG_HOME/.config/old_config"
    mkdir $ORG_HOME/.config/old_config
    if test -f $ORG_HOME/.vimrc; then
        mv $ORG_HOME/.vimrc $ORG_HOME/.config/old_config/.vimrc
    fi
    if test -f $ORG_HOME/.zshrc; then
        mv $ORG_HOME/.zshrc $ORG_HOME/.config/old_config/.zshrc
    fi
    if test -f $ORG_HOME/.tmux.conf; then
        mv $ORG_HOME/.tmux.conf $ORG_HOME/.config/old_config/.tmux.conf
    fi

    echo "copying config"
    cp $ORG_HOME/rcfiles/tmux/tmux_sourcer.conf $ORG_HOME/.tmux.conf
    cp $ORG_HOME/rcfiles/vim/vimrc_sourcer.vim $ORG_HOME/.vimrc
    cp $ORG_HOME/rcfiles/zsh/zshrc_sourcer.sh $ORG_HOME/.zshrc

    tmux source-file $ORG_HOME/.tmux.conf
    echo "All Good!"
    exit
    zsh
else
    # echo "If ran as root, also installs fzf and ripgrep"
    echo "Moving old config files to ~/.config/old_config"
    mkdir ~/.config/old_config
    if test -f ~/.vimrc; then
        mv ~/.vimrc ~/.config/old_config/.vimrc
    fi
    if test -f ~/.zshrc; then
        mv ~/.zshrc ~/.config/old_config/.zshrc
    fi
    if test -f ~/.tmux.conf; then
        mv ~/.tmux.conf ~/.config/old_config/.tmux.conf
    fi

    echo "copying config"
    cp ~/rcfiles/tmux/tmux_sourcer.conf ~/.tmux.conf
    cp ~/rcfiles/vim/vimrc_sourcer.vim ~/.vimrc
    cp ~/rcfiles/zsh/zshrc_sourcer.sh ~/.zshrc

    tmux source-file ~/.tmux.conf
    echo "All Good!"
    zsh
fi
