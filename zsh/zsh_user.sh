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
alias t="tmux -2 new-session -s"

alias tl="tmux -2 ls"
alias ta="tmux -2 attach"
alias tat="tmux -2 attach -t"
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

install_tmux_plugin_manager (){
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
if test -f "~/.zshrc"; then
    bindkey -v
    echo "Worked"
fi

# export KEYTIMEOUT=1

alias l="ls -al"
alias p="pwd"
alias c="cd"
alias dt="du -shc ./*"

alias aets="deactivate &> ~/null; source ~/venvs/tradesuite/Scripts/activate"
alias aead="deactivate &> ~/null; source ~/venvs/audalign/Scripts/activate"
alias aebk="deactivate &> ~/null; source ~/venvs/braspkeys/Scripts/activate"
alias de="deactivate"
#}}
#Var Functions{{
# cs12 then file on server to get, then place here to place
cs12 () {
    sudo scp -r -i /home/kaliben/.ssh/csci_112 k12t783@csci112.cs.montana.edu:$1 $2
}
cptocs12 () {
    sudo scp -r -i /home/kaliben/.ssh/csci_112 $1 k12t783@csci112.cs.montana.edu:$2
}
print_colors () {
for i in {0..255} ; do
    printf "\x1b[38;5;${i}m${i} "
done
}

svim () {
if test -f "./Session.vim"; then
    vim -S Session.vim
else
    vim
fi
}
cvim () {
if test -f "./Session.vim"; then
    echo Session.vim found
else
    echo Session.vim NOT found
fi
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
# Git {{
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

print_setup_github_ssh (){
    echo ssh-keygen -t rsa -b 4096 -C ben.f.miller24@gmail.com
    echo mv ~/.ssh/id_rsa ~/.ssh/id_rsa_github
    echo ssh-add ~/.ssh/id_rsa_github
    echo "\nCopy this\n"
    echo mv ~/.ssh/id_rsa.pub ~/.ssh/id_rsa_github.pub
    echo cat ~/.ssh/id_rsa_github.pub
    echo echo "\n"
    echo ssh -T git@github.com
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

chmastermain () {
    git branch -m master main
    git fetch origin
    git branch -u origin/main main
}
print_change_master_branch () {
    echo git branch -m master main
    echo git fetch origin
    echo git branch -u origin/main main
}

# set git ssh with "git remote set-url origin git@Github.com:benfmiller/....git"

#}}
alias print_add_ssh_passphrase="echo Add passphrase with \"ssh-keygen -p -f filename\""
#}}
# Aliases{{

alias gs="git status"
alias gp="git push"
alias gl="git pull"
alias ga="git add"
alias gc="git commit"
alias gh="git checkout"
alias glo="git log --online"
alias gls="git log --stat"
alias gm="git merge"

print_git_aliases (){
    echo gs=\"git status\"
    echo gp=\"git push\"
    echo gl=\"git pull\"
    echo ga=\"git add\"
    echo gc=\"git commit\"
    echo gh=\"git checkout\"
    echo glo=\"git log --online\"
    echo gls=\"git log --stat\"
    echo gm=\"git merge\"
}

# }}
print_git_tag (){
    echo git tag v*.*.*
    echo git push origin v*.*.*
    echo or git push origin --tags
}
print_ch_git_to_ssh () {
    echo git remote set-url origin git@github.com:name/repo.git
}
# }}
# Python {{
# Twine {{

print_python_push_pypi (){
    echo python setup.py sdist bdist_wheel   \# build wheels and tar\'s
    echo tar tzf realpython-reader-1.0.0.tar.gz   \# look at the package list
    echo twine check dist/*    \# make sure it all works
    echo twine upload --repository-url https://test.pypi.org/legacy/ dist/*     \# to testpypi
    echo twine upload dist/*     \# to pypi
}
#}}
#}}
# Print Alls {{
print_all_custom_funcs() {
    echo chmastermain
    echo setup_github_ssh
    echo cs12
    echo cptocs12
    echo install_oh_my_zsh
    echo install_vim_vim_plug
    echo install_neovim_vim_plug
    echo install_tmux_plugin_manager
    echo cpviminit
    echo cvim \(check if vim session is present\)
    echo svim \(open session.vim if found else open empty\)

    echo
    echo look at print completion for others
}

# }}
