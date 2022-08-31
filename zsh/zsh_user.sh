#!/usr/bin/env bash
#Moving Aliases{{
alias cdscripts="cd ~/rcfiles/scripts"
alias lscripts="ls ~/rcfiles/scripts"
#}}
#rcfiles {{
export copy_tmux_plugins=1
pullrcs (){
    temp_dir=$(pwd)
    cd ~/rcfiles
    git pull
    if uname | grep -qv 'Linux\|Darwin'; then
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
    cd ; mkdir ~/.config/nvim; cp ~/rcfiles/vim/init.vim ~/.config/nvim/;
}
#}}
#System{{
tupdate () {

    if  uname -a | grep -qs MANJARO || uname -a | grep -qs arch ; then
        sudo pacman -Syu
    else
        sudo apt update && sudo apt upgrade -y
    fi

    echo
    echo \"PullingRcs\"
    pullrcs
    zsh
}

if  uname -a | grep -qs MANJARO || uname -a | grep -qs arch ; then
    alias sinstal="sudo pacman -S"
else
    alias sinstal="sudo apt install"
fi
#}}
#Tmux{{
# This requires a name for session
alias t="tmux -2 new-session -s"

alias tl="tmux -2 ls"
alias ta="tmux -2 attach"
alias tat="tmux -2 attach -d -t"
alias tst="tmux switch-client -t"
alias tata="~/rcfiles/scripts/tmux_switcher.sh"
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
export PATH=~/.local/bin:$PATH
if [ ! -z "${HOME_MACHINE+x}" ]; then
    export PATH=$PATH:~/rcfiles/scripts
fi
export TMPDIR="/tmp"
export FZF_DEFAULT_OPTS='--bind=ctrl-k:up,ctrl-j:down'
export CN="$HOME/GoogleDrive/CProjects/Cnotes"
#}}
# Editor {{
export EDITOR='vim -u $HOME/rcfiles/vim/vimrc.vim'

alias vi="vim -u $HOME/rcfiles/vim/vimrc.vim"

if type nvim > /dev/null 2>&1; then
    alias vi='nvim -u $HOME/rcfiles/vim/vimrc.vim'
    alias vim="nvim"
    export EDITOR='nvim -u $HOME/rcfiles/vim/vimrc.vim'

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
if $(ps -p $$ | grep -q 'zsh'); then
    autoload -U edit-command-line
    zle -N edit-command-line
    bindkey '^f' edit-command-line
fi
#}}
# More Aliases{{
# for esc to edit line in vim normal mode
# if test -f "~/.zshrc"; then
    # bindkey -v
    # echo "Worked"
# fi

# export KEYTIMEOUT=1


if [ ! -z "${HOME_MACHINE+x}" ]; then
    alias winbash="/mnt/c/Program\ Files/Git/usr/bin/bash.exe -i -l"
    alias winbashex="/mnt/c/Program\ Files/Git/usr/bin/bash.exe -i -l -c"
fi
alias movetoparent="find . -mindepth 1 -maxdepth 1 -exec mv -t .. -- {} +"
alias explorer="explorer.exe ."
alias temperature="watch -n 2 sensors"
alias hib="i3lock -f -i "$HOME/.config/i3/icons/lock.png" ; sudo /usr/bin/systemctl hibernate"

alias setdisploc="export DISPLAY=:0"
alias setdispssh="export DISPLAY=localhost:10.0"

alias myrsync="rsync -avS --progress --delete"

alias top=bpytop

if ! command -v wslview &> /dev/null
then
    alias wslview="open"
fi

wv () {
    wslview $* &
}
wvap () {
    wslview *.pdf &
}

alias l="ls -alh"
alias lls="ls -lh"
alias p="pwd"
alias c="cd"
alias dt="du -chs * | sort -h"
alias df="df -h"
alias dfg="df | rg -v tmpfs"

alias aets="deactivate &> /dev/null; source ~/venvs/tradesuite/Scripts/activate"
alias aead="deactivate &> /dev/null; source ~/venvs/audalign/Scripts/activate"
alias aebk="deactivate &> /dev/null; source ~/venvs/braspkeys/Scripts/activate"
alias ae="source ./venv/bin/activate"
alias ac="conda activate"
alias de="deactivate &> /dev/null; conda deactivate"

alias ccr="cargo run"
alias ccb="cargo build"
alias cct="cargo test"

alias python="python3"
alias pip="pip3"

alias pm="pacman"

alias dk="docker"
alias tfw="terraform workspace"
alias ktx="kubectx"
alias kbn="kubens"
#}}
#Var Functions{{
print_colors () {
for i in {0..255} ; do
    printf "\x1b[38;5;${i}m${i} "
done
}

print_nmcli () {
    echo "nmcli dev status"
    echo "nmcli radio wifi"
    echo "nmcli radio wifi on"
    echo
    echo "nmcli dev wifi list"
    echo "sudo nmcli dev wifi connect {network-ssid}"
    echo 'sudo nmcli dev wifi connect {network-ssid} password {network-password}'
    echo "nmcli con up id {network-ssid} # uses existing profile"
    echo "sudo nmcli --ask dev wifi connect network-ssid # don't have to type password in command"
}

svim () {
session_name=".Session-$(hostname | tr -d "\n").vim"
if test -f $session_name; then
    vim -S $session_name
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

# cprc's {{
cprcminimum () {
    scp ~/rcfiles/zsh/zsh_user.sh $1:~/.zshrc
    scp ~/rcfiles/vim/vimrc.vim $1:~/.vimrc
    scp ~/rcfiles/tmux/tmux.conf $1:~/.tmux.conf
}

cprcminimumbash () {
    scp ~/rcfiles/zsh/zsh_user.sh $1:~/.bashrc
    scp ~/rcfiles/vim/vimrc.vim $1:~/.vimrc
    scp ~/rcfiles/tmux/tmux.conf $1:~/.tmux.conf
}

cprcminimumhome () {
    scp ~/.zshrc $1:~/.zshrc
    scp ~/.vimrc $1:~/.vimrc
    scp ~/.tmux.conf $1:~/.tmux.conf
}
cprcminimumhomebash () {
    scp ~/.bashrc $1:~/.bashrc
    scp ~/.vimrc $1:~/.vimrc
    scp ~/.tmux.conf $1:~/.tmux.conf
}
# }}

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

unpackpyimagesearch () {
    filename=$(ls $HOME/Downloads)
    basename="${filename%.*}"
    mv $HOME/Downloads/* ../
    cd ..
    unzip $filename
    mv $filename $basename
    cd $basename
}

edge () {
    edge_path="/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe"
    $(/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe $($HOME/rcfiles/scripts/edge.py `pwd -P` $1))
}

apdf () {
    $(/mnt/c/Program\ Files\ \(x86\)/Adobe/Acrobat\ DC/Acrobat/Acrobat.exe $($HOME/rcfiles/scripts/edge.py `pwd -P` $1))
}

# Pandoc {{
pandoct () {
    filename=$(basename -- "$1")
    # extension="${1##*.}"
    extension="${1##*/}"
    filename="${1%.*}"
    pandoc -s --template=$HOME/rcfiles/texts/pandoc/mdToPDF.tex $1 -o $filename.pdf;
}

pandoctx () {
    filename=$(basename -- "$1")
    # extension="${1##*.}"
    extension="${1##*/}"
    filename="${1%.*}"
    pandoc -s --template=$HOME/rcfiles/texts/pandoc/mdToPDF.tex $1 -o $filename.docx;
}

pandocsimple () {
    filename=$(basename -- "$1")
    # extension="${1##*.}"
    extension="${1##*/}"
    filename="${1%.*}"
    pandoc -s $1 -o $filename.pdf;
}

pandocsimplex () {
    filename=$(basename -- "$1")
    # extension="${1##*.}"
    extension="${1##*/}"
    filename="${1%.*}"
    pandoc -s $1 -o $filename.docx;
}
pdsv () {
    filename=$(basename -- "$1")
    # extension="${1##*.}"
    extension="${1##*/}"
    filename="${1%.*}"
    pandoc -s $1 -o $filename.pdf;
    wslview $filename.pdf
}
pdtv () {
    filename=$(basename -- "$1")
    # extension="${1##*.}"
    extension="${1##*/}"
    filename="${1%.*}"
    pandoc -s --template=$HOME/rcfiles/texts/pandoc/mdToPDF.tex $1 -o $filename.pdf;
    wslview $filename.pdf
}
pds () {
    filename=$(basename -- "$1")
    # extension="${1##*.}"
    extension="${1##*/}"
    filename="${1%.*}"
    pandoc -s $1 -o $filename.pdf;
}
pdt () {
    filename=$(basename -- "$1")
    # extension="${1##*.}"
    extension="${1##*/}"
    filename="${1%.*}"
    pandoc -s --template=$HOME/rcfiles/texts/pandoc/mdToPDF.tex $1 -o $filename.pdf;
}
wslviewpdf () {
    filename=$(basename -- "$1")
    # extension="${1##*.}"
    extension="${1##*/}"
    filename="${1%.*}"
    # wslview `pwd`/${filename}.pdf;
    wslview ${filename}.pdf;
}
#}}
#}}
# Oh-my-zsh config {{
#Zsh Path{{
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
#}}
# ZSH Options{{
#
# TERM=xterm-color
#
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
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
# Theme{{
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="pygmalion-virtualenv"
# gnzh
# mikeh
# agnoster
# af-magic
# fishy
# obraun
# linuxonly

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
#}}
# Plugins{{
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode tmux sudo zsh-interactive-cd fzf terraform direnv)
#}}
# }}
# Bash Prompt {{
# Alternate Prompts {{
# https://medium.com/@damianczapiewski/how-to-pimp-up-the-git-bash-prompt-on-windows-without-any-external-stuff-c69eb9ef0125
# https://blog.devgenius.io/how-to-customize-the-git-bash-shell-prompt-336f6aefcf3f

# origin_dist () {
#  local STATUS="$(git status 2> /dev/null)"
#  local DIST_STRING=""
#  local IS_AHEAD=$(echo -n "$STATUS" | grep "ahead")
#  local IS_BEHIND=$(echo -n "$STATUS" | grep "behind")
#  if [ ! -z "$IS_AHEAD" ]; then
#   local DIST_VAL=$(echo "$IS_AHEAD" | sed 's/[^0-9]*//g')
#   DIST_STRING="$DIST_VAL ››"
#  elif [ ! -z "$IS_BEHIND" ]; then
#   local DIST_VAL=$(echo "$IS_BEHIND" | sed 's/[^0-9]*//g')
#   DIST_STRING="‹‹ $DIST_VAL"
#  fi
#  if [ ! -z "$DIST_STRING" ]; then
#   echo -en "\e[1;7m $DIST_STRING "
#  fi
# }

# __PS1_GIT_DIST='`origin_dist`'

# __PS1="${__PS1_BEFORE}${__PS1_TIME}${__PS1_USER}${__PS1_LOCATION}${__PS1_GIT_BRANCH}${__PS1_GIT_DIST}${__PS1_AFTER}"
# ORIG_PS1="$PS1"


# git_stats() {
#   local STATUS=$(git status -s 2> /dev/null)
#   local ADDED=$(echo "$STATUS" | grep '??' | wc -l)
#   local DELETED=$(echo "$STATUS" | grep ' D' | wc -l)
#   local MODIFIED=$(echo "$STATUS" | grep ' M' | wc -l)
#   local STATS=''
#   if [ $ADDED != 0 ]; then
#     STATS="\e[42m $ADDED "
#   fi
#   if [ $DELETED != 0 ]; then
#     STATS="$STATS\e[101m $DELETED "
#   fi
#   if [ $MODIFIED != 0 ]; then
#     STATS="$STATS\e[30;103m $MODIFIED "
#   fi
#   echo -e "\e[0m    $STATS\e[0m"
# }
# __PS1_BEFORE='\[\e[42;97m\] \t '
# __PS1_USER='\[\e[97;104m\] \u@\h '
# __PS1_LOCATION='\[\e[30;43m\] \w '
# __PS1_GIT_BRANCH='\[\e[97;45m\]`__git_ps1` ' __PS1_GIT_STATS='`git_stats` '
# __PS1_AFTER='\[\e[0m\]\n\[\e[42;97m\]\$ \[\e[0m\] '

# # export PS1="${__PS1_BEFORE}${__PS1_USER}${__PS1_LOCATION}${__PS1_GIT_BRANCH}${__PS1_GIT_STATS}${__PS1_AFTER}"
# # export PS1="${__PS1_BEFORE}${__PS1_USER}${__PS1_GIT_BRANCH}${__PS1_AFTER}"
# export PS1="\t ${PS1}"

# -----------------------------------------------------------------------------------------------------------------
#}}
if ps -p $$ | grep -q 'bash'; then
    # from c/program files/Git/etc/profile.d/git-prompt.sh

if test -f /etc/profile.d/git-sdk.sh
then
    TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
    TITLEPREFIX=$MSYSTEM
fi

if test -f ~/.config/git/git-prompt.sh
then
    . ~/.config/git/git-prompt.sh
else
    PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]' # set window title
    # PS1="$PS1"'\n'                 # new line
    PS1="$PS1"'\[\033[94m\][\t] '     # time
    PS1="$PS1"'\[\033[32m\]'       # change to green
    PS1="$PS1"'\u@\h '             # user@host<space>
    PS1="$PS1"'\[\033[35m\]'       # change to purple
    PS1="$PS1"'$MSYSTEM '          # show MSYSTEM
    PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
    PS1="$PS1"'\w'                 # current working directory
    if test -z "$WINELOADERNOEXEC"
    then
        GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
        COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
        COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
        COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
        if test -f "$COMPLETION_PATH/git-prompt.sh"
        then
            . "$COMPLETION_PATH/git-completion.bash"
            . "$COMPLETION_PATH/git-prompt.sh"
            PS1="$PS1"'\[\033[36m\]'  # change color to cyan
            PS1="$PS1"'`__git_ps1`'   # bash function
        fi
    fi
    PS1="$PS1"'\[\033[0m\]'        # change color
    PS1="$PS1"'\n'                 # new line
    PS1="$PS1"'$ '                 # prompt: always $
fi

MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc

# # Evaluate all user-specific Bash completion scripts (if any)
# if test -z "$WINELOADERNOEXEC"
# then
#     for c in "$HOME"/bash_completion.d/*.bash
#     do
#         # Handle absence of any scripts (or the folder) gracefully
#         test ! -f "$c" ||
#         . "$c"
#     done
# fi
fi
if ps -p $$ | grep -q 'zsh'; then
    if [ "$USERNAME" = "root" ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi

    local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

    PROMPT='%{$fg[green]%}[%*]%{$reset_color%} %{$fg_no_bold[cyan]%}%n %{${fg_bold[blue]}%}::%{$reset_color%} %{$fg[yellow]%}%m%{$reset_color%} %{$fg_no_bold[magenta]%} ➜ %{$reset_color%} %{${fg[green]}%}%3~ $(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}»%{${reset_color}%} '

    RPS1="${return_code}"

    ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}‹"
    ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
fi
# }}
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
if [ ! -z "${INCLUDE_GITHUB_KEYS+x}" ];
then
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
        if test -f "~/.ssh/id_ed25519_github"; then
            ssh-add ~/.ssh/id_ed25519_github
        else
            ssh-add ~/.ssh/id_rsa_github
        fi

    elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
        ssh-add
        if test -f "~/.ssh/id_ed25519_github"; then
            ssh-add ~/.ssh/id_ed25519_github
        else
            ssh-add ~/.ssh/id_rsa_github
        fi
    fi

    unset env
fi
#}}
# Git branch main updater{{

git_chmastermain () {
    echo first change the branch name on github
    git branch -m master main
    git fetch origin
    git branch -u origin/main main
    git remote set-head origin -a
}
print_git_change_master_branch () {
    echo first change the branch name on github
    echo git branch -m master main
    echo git fetch origin
    echo git branch -u origin/main main
    echo git remote set-head origin -a
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
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias gp="git push"
alias gl="git pull"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gch="git checkout"
alias glo="git log -p"
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
alias gcb="git clone --bare"

alias gpra="git config --add oh-my-zsh.hide-status 0; git config --add oh-my-zsh.hide-dirty 0"
alias gprr="git config --add oh-my-zsh.hide-status 1; git config --add oh-my-zsh.hide-dirty 1"

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
    echo gch=\"git checkout\"
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

print_git_pr () {
    echo \# If you haven\'t set up your remote yet, run this line:
    echo \# git remote add upstream https://github.com/konradjk/exac_browser.git
    echo "\033[1;32mgit fetch --all \033[0m                                  # Get the latest code"
    echo "\033[1;32mgit checkout -b my-single-change upstream/master \033[0m # Create new branch based on upstream/master"
    echo "\033[1;32mgit cherry-pick b50b2e7 \033[0m                          # Cherry pick the commit you want"
    echo "\033[1;32mgit push -u origin my-single-change \033[0m              # Push your changes to the remote branch"
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
    echo cpnviminit
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
# Some Bindings {{
if $(ps -p $$ | grep -q 'zsh'); then
    VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
    VI_MODE_SET_CURSOR=true

    bindkey -M viins 'jk' vi-cmd-mode

    # for clear screen
    # zsh-clear () {clear}
    # zle -N zsh-clear
    # bindkey '^o' zsh-clear
    bindkey -s '^o' 'clear^M'

    bindkey -s '^y' 'mysyncto^M'

fi
# }}
