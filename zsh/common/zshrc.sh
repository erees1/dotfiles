ZSH_DOT_DIR=$(realpath $(dirname $(realpath ${(%):-%x}))/..)
export DOT_DIR=$(realpath $ZSH_DOT_DIR/../)

ZSH_DISABLE_COMPFIX=true
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH=$HOME/.oh-my-zsh

# Must source colors before loading plugins
source $ZSH_DOT_DIR/common/dir_colors.sh

VI_MODE_SET_CURSOR=true
plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search vi-mode)

function add_to_path() {
    p=$1
    if [[ "$PATH" != *"$p"* ]]; then
      export PATH="$p:$PATH"
    fi
}

add_to_path "${HOME}/.local/bin"
add_to_path "${DOT_DIR}/custom_bins"
add_to_path "${HOME}/.npm-global/bin"

# Add any custom completions
fpath=($ZSH_DOT_DIR/completions $fpath)

source $ZSH/oh-my-zsh.sh
source $ZSH_DOT_DIR/common/p10k.zsh
source $ZSH_DOT_DIR/common/aliases.sh
source $ZSH_DOT_DIR/common/extras.sh
source $ZSH_DOT_DIR/common/keybindings.sh


# Source fzf file
bindkey -r "^R"  # Remove ctrl-r binding
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
