#!/bin/sh

# echo "$(dirname "$0")" ; echo "$(basename "$0")"
# export NEW_PATH=realpath "$(dirname "$0")"

if [ `whoami` = 'root' ]
  then
    echo "Don't use root!"
    return 1
fi

ln -s ~/.config/nvim ~/rcfiles/vim/nvim

echo "Moving old config files to ~/.config/old_config"
mkdir -p ~/.config/old_config
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
cp ~/rcfiles/tmux/tmux_plugins_sourcer.conf ~/.tmux_plugins.conf
cp ~/rcfiles/vim/vimrc_sourcer.vim ~/.vimrc
cp ~/rcfiles/zsh/zshrc_sourcer.sh ~/.zshrc

tmux source-file ~/.tmux.conf
echo "All Good!"
echo "errors are normal"
echo "also install fzf, bat, ripgrep, neovim"
echo "run install_ tmux zsh and plug"
echo "prefix I in tmux to install"
echo "print_ is your friend"
echo "run cpnviminit if using neovim"
echo "configure your ssh"
echo "also maybe install pandoc and texlive stuff"
zsh
