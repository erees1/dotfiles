
source $HOME/git/dotfiles/vars.sh
ZSH_DISABLE_COMPFIX=true
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions history-substring-search)

# add ./local/bin to path
p="${HOME}/.local/bin"
if [[ "$PATH" != *"$p"* ]]; then
  export PATH="$p:$PATH"
fi

source $ZSH/oh-my-zsh.sh
source ~/git/dotfiles/zsh/common/p10k.zsh
source ~/git/dotfiles/zsh/common/aliases.sh
source ~/git/dotfiles/zsh/common/extras.sh
source ~/git/dotfiles/zsh/common/keybindings.sh
