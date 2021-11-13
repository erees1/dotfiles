
SRC_DIR=$(dirname $(realpath $0))

ZSH_DISABLE_COMPFIX=true
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH=$HOME/.oh-my-zsh

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions history-substring-search)
#KEYTIMEOUT=20

# add ./local/bin to path
p="${HOME}/.local/bin"
if [[ "$PATH" != *"$p"* ]]; then
  export PATH="$p:$PATH"
fi

# Source fzf file
bindkey -r "^R"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

VI_MODE_SET_CURSOR=true

source $ZSH/oh-my-zsh.sh
source $SRC_DIR/p10k.zsh
source $SRC_DIR/aliases.sh
source $SRC_DIR/extras.sh
source $SRC_DIR/keybindings.sh
source $SRC_DIR/vi-mode.sh
