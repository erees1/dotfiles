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
source ~/git/dotfiles/zsh/common/p10k.zsh
source ~/git/dotfiles/zsh/common/aliases.sh
source ~/git/dotfiles/zsh/common/extras.sh
source ~/git/dotfiles/zsh/common/keybindings.sh
source ~/git/dotfiles/zsh/common/vi-mode.sh
