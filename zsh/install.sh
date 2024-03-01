#!/bin/bash

# use value of ZSH_PLUGIN_DIR if it exists (set in env.zsh)
PLUGINS_DIR=${ZSH_PLUGIN_DIR:-"$HOME/.zsh/plugins"}

if [ -d $PLUGINS_DIR ] && [ -z "$FORCE" ]; then
    echo "Skipping download of oh-my-zsh and related plugins, set FORCE=1 to force install"
else
    rm -rf $PLUGINS_DIR

    git clone https://github.com/romkatv/powerlevel10k.git \
        ${PLUGINS_DIR}/powerlevel10k 

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${PLUGINS_DIR}/zsh-syntax-highlighting 

    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${PLUGINS_DIR}/zsh-autosuggestions 

    git clone https://github.com/zsh-users/zsh-completions \
        ${PLUGINS_DIR}/zsh-completions 

    git clone https://github.com/zsh-users/zsh-history-substring-search \
        ${PLUGINS_DIR}/zsh-history-substring-search 

    git clone https://github.com/Aloxaf/fzf-tab \
        ${PLUGINS_DIR}/fzf-tab
fi
