ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/git/dotfiles/zsh/p10k.zsh
source ~/git/dotfiles/zsh/aliases.sh
source ~/git/dotfiles/zsh/extras.sh