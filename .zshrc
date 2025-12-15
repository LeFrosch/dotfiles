export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="cat"

# enable zsh plugins
plugins=(git zsh-vi-mode)
source $ZSH/oh-my-zsh.sh

# configure vim
bindkey -M vicmd "j" up-line-or-beginning-search
bindkey -M vicmd "k" down-line-or-beginning-search 
export ZVM_VI_INSERT_ESCAPE_BINDKEY="jj"

export EDITOR="nvim"

# copy/paste aliases on linux
if [[ $(uname -s) == "Linux" ]]; then
	alias pbcopy="xclip -i -selection clipboard"
	alias pbpaste="xclip -o -selection clipboard"
fi

# function to concatenet all files
rcat() {
  find $1 -not -path '*/.*' -type f | while read -r file; do
    echo "--- File: $file ---"
    cat "$file"
    echo ""
  done
}

# environment
[[ -f ~/.zsh_exports ]] && source ~/.zsh_exports

path+=("$HOME/.local/bin")
export PATH

# enable zoxide
eval "$(zoxide init zsh --cmd cd)"

# enable fit completion
compdef fit=git
