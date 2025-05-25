export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="cat"

# enable zsh plugins
source $ZSH/oh-my-zsh.sh

# configure vim
bindkey -M vicmd "j" up-line-or-beginning-search
bindkey -M vicmd "k" down-line-or-beginning-search 
export ZVM_VI_INSERT_ESCAPE_BINDKEY="jj"

export EDITOR="nvim"

# environment
[[ -f ~/.zsh_exports ]] && source ~/.zsh_exports

path+=("$HOME/.local/bin")
export PATH

# enable zoxide
eval "$(zoxide init zsh --cmd cd)"
