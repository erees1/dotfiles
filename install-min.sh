PLUGINS_DIR=${ZSH_PLUGIN_DIR:-"$HOME/.zsh/plugins"}

brew install coreutils
brew install fzf
brew install bat
brew install git-delta

git clone https://github.com/romkatv/powerlevel10k.git \
    ${PLUGINS_DIR}/powerlevel10k 

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${PLUGINS_DIR}/zsh-syntax-highlighting 

git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${PLUGINS_DIR}/zsh-autosuggestions 