source ~/rcfiles/zsh/zsh_user.sh
source $ZSH/oh-my-zsh.sh

# export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

source "$HOME/.cargo/env"
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

export copy_tmux_plugins=0
export HOME_MACHINE=1
export INCLUDE_GITHUB_KEYS=1
