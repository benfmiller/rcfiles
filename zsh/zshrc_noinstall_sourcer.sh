source ~/rcfiles/zsh/zsh_zsh.sh
# wsl Moving Aliases {{
alias cdp="cd /mnt/c/users/benfm/GoogleDrive/CProjects"
alias cn="cd /mnt/c/users/benfm/GoogleDrive/CProjects/Cnotes"
alias cw="cdp && cd ClassWork"
alias ch="cd /mnt/c/users/benfm/"
export CH="/mnt/c/users/benfm/"
#}}
# Theme{{
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="linuxonly"
#fishy
#obraun

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
plugins=(git python vi-mode tmux jump z)
#}}
source $ZSH/oh-my-zsh.sh
source ~/rcfiles/zsh/zsh_user.sh

export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

source "$HOME/.cargo/env"
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
