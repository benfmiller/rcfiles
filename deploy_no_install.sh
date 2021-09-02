#!/bin/sh

if [ `whoami` = 'root' ]
  then
    echo "Don't use as root!"
    return 1
fi

echo "Moving old config files to ~/.config/old_config"
mkdir -p ~/.config/old_config
if test -f "~/.vimrc"; then
    mv ~/.vimrc ~/.config/old_config/.vimrc
fi
if test -f "~/.zshrc"; then
    mv ~/.zshrc ~/.config/old_config/.zshrc
fi
if test -f "~/.tmux.conf"; then
    mv ~/.tmux.conf ~/.config/old_config/.tmux_conf
fi

echo "copying config"
cp ~/rcfiles/tmux/tmux_sourcer.conf ~/.tmux.conf
cp ~/rcfiles/tmux/tmux_plugins_sourcer.conf ~/.tmux_plugins.conf
cp ~/rcfiles/vim/vimrc_noinstall_sourcer.vim ~/.vimrc
cp ~/rcfiles/zsh/zshrc_noinstall_sourcer.sh ~/.zshrc

tmux source-file ~/.tmux.conf
echo "All Good!"
echo "errors are normal"
echo "run install_ tmux zsh and plug, doesn't require root"
echo "prefix I in tmux to install"
echo "print_ is your friend"
echo "run cpnviminit if using neovim"
echo "configure your ssh"
zsh
