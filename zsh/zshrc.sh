ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions history-substring-search)

source $ZSH/oh-my-zsh.sh
source ~/git/dotfiles/zsh/p10k.zsh
source ~/git/dotfiles/zsh/aliases.sh
source ~/git/dotfiles/zsh/extras.sh