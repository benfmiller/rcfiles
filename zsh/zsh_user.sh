#Moving Aliases{{
#}}
#rcfiles {{
alias pullrcs="cd ;cd rcfiles; git pull; cd ;"
alias pushrcs="cd ;cd rcfiles; git push; cd ;"
cpnviminit () {
    cd ; mkdir .config/nvim; cp rcfiles/vim/init.vim .config/nvim/;
}
#}}
#System{{
alias tupdate="sudo apt update && sudo apt upgrade -y"
alias sinstal="sudo apt install"
#}}
#Tmux{{
# This requires a name for session
alias t="tmux new-session -s"

alias tl="tmux ls"
alias ta="tmux attach"
alias tat="tmux attach -t"
#}}
#Installers{{
install_oh_my_zsh () {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}
install_vim_vim_plug () {
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}
install_neovim_vim_plug () {
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}
# ycm requires install.py
# nvim in .local/share/nvim/plugged/YouCompleteMe
# vim in .vim/plugged/YouCompleteMe
#}}
# Path{{
export PATH=~/.local/bin:$PATH

#}}
# Editor {{
export EDITOR='vim'

if type nvim > /dev/null 2>&1; then
    alias vim='nvim'
    export EDITOR='nvim'
fi
#}}
# More Aliases{{
# for esc to edit line in vim normal mode
bindkey -v

# export KEYTIMEOUT=1

alias gs="git status"
alias l="ls -al"
alias p="pwd"
alias c="cd"
#}}
#Var Functions{{
# cs12 then file on server to get, then place here to place
cs12 () {
    sudo scp -r -i /home/kaliben/.ssh/csci_112 k12t783@csci112.cs.montana.edu:$1 $2
}
cptocs12 () {
    sudo scp -r -i /home/kaliben/.ssh/csci_112 $1 k12t783@csci112.cs.montana.edu:$2
}
#}}
# Zsh Suggested User configuration? {{


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#}}
# Github {{
# SetupKeys{{
setup_github_ssh () {
    ssh-keygen -t rsa -b 4096 -C ben.f.miller24@gmail.com
    mv ~/.ssh/id_rsa ~/.ssh/id_rsa_github
    ssh-add ~/.ssh/id_rsa_github
    echo "\nCopy this\n"
    mv ~/.ssh/id_rsa.pub ~/.ssh/id_rsa_github.pub
    cat ~/.ssh/id_rsa_github.pub
    echo "\n"
    ssh -T git@github.com
    echo "Make sure gits are ssh connected"
}
# If already have key, just add to ssh-agent and check if connected to github
# Start agent in background with "eval `ssh-agent -s`"
# If error persists, do it with the shell that added it in the first place
#}}
# Start ssh-agent{{
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
    ssh-add ~/.ssh/id_rsa_github
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
    ssh-add ~/.ssh/id_rsa_github
fi

unset env
#}}
# Git branch main updater{{

# git branch -m master main
# git fetch origin
# git branch -u origin/main main

#}}
# Add passphrase with ssh-keygen -p -f filename
#}}