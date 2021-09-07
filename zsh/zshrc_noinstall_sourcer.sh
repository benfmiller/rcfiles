source ~/rcfiles/zsh/zsh_zsh.sh
source ~/rcfiles/zsh/zsh_user.sh
# Plugins{{
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git python vi-mode tmux jump z)
#}}
source $ZSH/oh-my-zsh.sh

export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

source "$HOME/.cargo/env"
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

export copy_tmux_plugins=0
export HOME_MACHINE=1
export INCLUDE_GITHUB_KEYS=1
