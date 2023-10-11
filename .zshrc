export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="cat"

# enable zsh plugins
plugins=(git zsh-vi-mode)
source $ZSH/oh-my-zsh.sh

# configure vim
bindkey -M vicmd "j" up-line-or-beginning-search
bindkey -M vicmd "k" down-line-or-beginning-search 
export ZVM_VI_INSERT_ESCAPE_BINDKEY="jj"

export EDITOR="vim"

# how to export to path
# path+=("/home/daniel/.local/bin")
# export PATH
