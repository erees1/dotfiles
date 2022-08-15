
ZSH_DOT_DIR=$(realpath $(dirname $(realpath ${(%):-%x}))/..)
export DOT_DIR=$(realpath $ZSH_DOT_DIR/../)

. $ZSH_DOT_DIR/utils.sh

ZSH_DISABLE_COMPFIX=true
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH=$HOME/.oh-my-zsh

# Must source colors before loading plugins
source $ZSH_DOT_DIR/common/dir_colors.sh

VI_MODE_SET_CURSOR=true
plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search vi-mode)


add_to_path "${DOT_DIR}/custom_bins"
add_to_path "${HOME}/.npm-global/bin"

# Add any custom completions
fpath=($ZSH_DOT_DIR/completions $fpath)

source $ZSH/oh-my-zsh.sh
source $ZSH_DOT_DIR/common/p10k.zsh
source $ZSH_DOT_DIR/common/aliases.sh
source $ZSH_DOT_DIR/common/options.sh
source $ZSH_DOT_DIR/common/keybindings.sh


# Source fzf file
bindkey -r "^R"  # Remove ctrl-r binding
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# add pyenv if pyenv isntalled and not in SIF
if [[ -z $SINGULARITY_CONTAINER ]]; then
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
      if command pyenv virtualenv --help 1>/dev/null 2>&1; then
        eval "$(pyenv virtualenv-init -)"
      fi
      SUB='.pyenv/shims'
      if [[ "$PATH" != *"$SUB"* ]]; then
        eval "$(pyenv init --path)"
      fi
    fi
fi
