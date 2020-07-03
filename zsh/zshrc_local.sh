ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions history-substring-search)

source $ZSH/oh-my-zsh.sh
source ~/git/dotfiles/zsh/p10k.zsh
source ~/git/dotfiles/zsh/aliases.sh
source ~/git/dotfiles/zsh/extras.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/edwardrees/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/edwardrees/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/edwardrees/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/edwardrees/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<