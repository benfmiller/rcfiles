#Moving Aliases{{
alias cdscripts="cd ~/rcfiles/scripts"
alias lscripts="ls ~/rcfiles/scripts"
#}}
#rcfiles {{
pullrcs (){
    temp_dir=$(pwd)
    cd ~/rcfiles
    git pull
    if uname | grep -qv 'Linux'; then
        cp ~/rcfiles/vim/vimrc.vim ~/.vimrc
        cat ~/rcfiles/vim/windows_addon.vim >> ~/.vimrc
        echo vim copied for windows
    fi
    if [ $copy_tmux_plugins -eq 1 ]; then
        cp ~/rcfiles/tmux/tmux_plugins_sourcer.conf ~/.tmux_plugins.conf
        echo tmux plugins copied
    fi
    cd $temp_dir
}
alias pushrcs="cd ;cd rcfiles; git push; cd ;"
cpnviminit () {
    cd ; mkdir .config/nvim; cp rcfiles/vim/init.vim .config/nvim/;
}
#}}
#System{{
alias tupdate="sudo apt update && sudo apt upgrade -y ; echo ; echo \"PullingRcs\" ; pullrcs ; zsh"
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

install_rust(){
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh;
    rustup install nightly;
    rustup default nightly;
}

install_chtsh_user(){ # requires rlwrap
    PATH_DIR="$HOME/.local/bin"  # or another directory on your $PATH
    mkdir -p "$PATH_DIR"
    curl https://cht.sh/:cht.sh > "$PATH_DIR/cht.sh"
    chmod +x "$PATH_DIR/cht.sh"
}
install_chtsh_glob(){ # requires rlwrap
    curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
    chmod +x /usr/local/bin/cht.sh
}

# ycm requires install.py
# nvim in .local/share/nvim/plugged/YouCompleteMe
# vim in .vim/plugged/YouCompleteMe
#}}
# Path{{
export PATH=~/.local/bin:$PATH:~/rcfiles/scripts
export TMPDIR="/tmp"
#}}
# Editor {{
export EDITOR='vim'

if type nvim > /dev/null 2>&1; then
    alias vim='nvim'
    export EDITOR='nvim'

    # Uses nvr if inside nvim instance
    # requires pip3 install neovim-remote
    if [ -n "$NVIM_LISTEN_ADDRESS"  ]; then
        if [ -x "$(command -v nvr)"  ]; then
            alias vim=nvr
            export EDITOR='nvim'
        else
            alias vim='echo "No nesting!"'
        fi
    fi
fi

# opens command line in vim
if uname | grep -q 'Linux'; then
    autoload -U edit-command-line
    zle -N edit-command-line
    bindkey '^x^e' edit-command-line
fi
#}}
# More Aliases{{
# for esc to edit line in vim normal mode
# if test -f "~/.zshrc"; then
    # bindkey -v
    # echo "Worked"
# fi

# export KEYTIMEOUT=1

alias winbash="/mnt/c/Program\ Files/Git/usr/bin/bash.exe -i -l"
alias temperature="watch -n 2 sensors"

alias l="ls -alh"
alias p="pwd"
alias c="cd"
alias dt="du -shc ./*"

alias aets="deactivate &> ~/null; source ~/venvs/tradesuite/Scripts/activate"
alias aead="deactivate &> ~/null; source ~/venvs/audalign/Scripts/activate"
alias aebk="deactivate &> ~/null; source ~/venvs/braspkeys/Scripts/activate"
alias de="deactivate"

alias ccr="cargo run"
alias ccb="cargo build"
#}}
#Var Functions{{
print_colors () {
for i in {0..255} ; do
    printf "\x1b[38;5;${i}m${i} "
done
}

svim () {
if test -f "./Session.vim"; then
    vim -S $1
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

ecn () {
    ck;
    svim
}

cmdir () {
    mkdir $1
    cd $1
}

generate_guid () {
    if uname | grep -qv 'Linux'; then
        python -c 'import uuid; print(str(uuid.uuid4()))'
    else
        python3 -c 'import uuid; print(str(uuid.uuid4()))'
    fi
}

wordtotext () {
    filename=$(basename -- "$1")
    # extension="${1##*.}"
    extension="${1##*/}"
    filename="${1%.*}"
    unzip -p $filename.docx word/document.xml | sed -e 's/<\/w:p>/\n/g; s/<[^>]\{1,\}>//g; s/[^[:print:]\n]\{1,\}//g' > $filename.txt;
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

print_git_setup_github_ssh (){
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

git_chmastermain () {
    git branch -m master main
    git fetch origin
    git branch -u origin/main main
}
print_git_change_master_branch () {
    echo git branch -m master main
    echo git fetch origin
    echo git branch -u origin/main main
    echo
    echo "run git_chmastermain to do above code"
}

# set git ssh with "git remote set-url origin git@Github.com:benfmiller/....git"

#}}
alias print_add_ssh_passphrase="echo Add passphrase with \"ssh-keygen -p -f filename\""
#}}
# Aliases{{
alias gs="git status"
alias gss="git status -s"
alias gsb="git status -sb"
alias gp="git push"
alias gl="git pull"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gh="git checkout"
alias glo="git log --oneline"
alias gls="git log --stat"
alias gm="git merge"
alias gbd="git branch -d"
alias gbl="git blame -b -w"
alias gb="git branch"
alias gd="git diff"
alias gw="git worktree"
alias gwa="git worktree add"
alias gwr="git worktree remove"
alias gwl="git worktree list"

glt () {
    # 2013-11-22
    git log --after="$1 00:00:00" --before="$1 23:59:59"
}

gltr () {
    # 2013-11-22
    git log --after="$1 00:00:00" --before="$2 23:59:59"
}

print_git_aliases (){
    echo gs=\"git status\"
    echo gp=\"git push\"
    echo gl=\"git pull\"
    echo ga=\"git add\"
    echo gaa=\"git add --all\"
    echo gc=\"git commit\"
    echo gh=\"git checkout\"
    echo glo=\"git log --online\"
    echo gls=\"git log --stat\"
    echo gm=\"git merge\"
    echo gbd=\"git branch -d\"
    echo gbl=\"git blame -b -w\"
    echo gd=\"git diff\"
    echo gw=\"git worktree\"
    echo gwa=\"git worktree add\"
    echo gwr=\"git worktree remove\"
    echo gwl=\"git worktree list\"
}

ginit () {
    git init
    git checkout -b main
}

git_largest_files() {
    git rev-list --objects --all |
    git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
    sed -n 's/^blob //p' |
    sort --numeric-sort --key=2 |
    cut -c 1-12,41- |
    $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}
git_largest_files_no_head() {
    git rev-list --objects --all |
    git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
    sed -n 's/^blob //p' |
    grep -vF --file=<(git ls-tree -r HEAD | awk '{print $3}') |
    sort --numeric-sort --key=2 |
    cut -c 1-12,41- |
    $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}


# }}
print_git_tag (){
    echo "git tag v*.*.*"
    echo "git push origin v*.*.*"
    echo "or git push origin --tags"
}
print_git_ch_to_ssh () {
    echo git remote set-url origin git@github.com:name/repo.git
}
print_git_submodule () {
    echo
    echo -e "\033[1;32mgit submodule add git@github.com:name/repo.git"
    echo git diff --cached --submodule
    echo git push origin main
    echo
    echo git log -p --submodule
    echo "  //logs of submodules"
    echo
    echo git submodule update --remote
    echo
    echo git submodule update --init --recursive
    echo "  //sets up new ones if they're added at origin"
    echo
    echo git submodule sync --recursive
    echo "  //needed if url is changed"
    echo
    echo git push --recurse-submodules=check
    echo "  //only pushes superproject if subprojects are also pushed"
    echo
    echo git clone --recurse-submodules git@github.com:name/repo.git
    echo "  //or regular clone it then run: git submodule init\; git submodule update"
    echo -e "\033[0m"
    echo git config status.submodulesummary 1
    echo "  //shows changes to submodules in git status"
    echo git config submodule.recurse true
    echo "  //always recurses submodules"
    echo git config --global diff.submodule log
    echo "  //shows git diffs with commits of submodule"
    echo git config -f .gitmodules submodule.{submoduleName}.branch {branchName}
    echo "  //sets which branch to use"
    echo
    echo config aliases maybe wanted
    echo git config alias.sdiff '!'"git diff && git submodule foreach 'git diff'"
    echo git config alias.spush 'push --recurse-submodules=on-demand'
    echo git config alias.supdate 'submodule update --remote --merge'
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
pytestc () {
    pytest --cov=$1 --cov-report=html
}
#}}
# Print Alls {{
print_all_custom_funcs() {
    echo chmastermain
    echo setup_github_ssh
    echo git_largest_files
    echo git_largest_files_no_head
    echo generate_guid
    echo cs12
    echo cptocs12
    echo cpviminit
    echo cvim \(check if vim session is present\)
    echo svim \(open session.vim if found else open empty\)
    echo ginit
    echo cmdir
    echo lscripts and cdscripts
    echo wordtotext
    echo
    echo install_ tab completion

    echo
    echo look at print completion for others
    echo look in rcfiles/scripts
}

# }}
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

bindkey -M viins 'jk' vi-cmd-mode
