#!/bin/bash
set -euo pipefail

# zsh plugins use value of ZSH_PLUGINS_DIR if it exists (set in base.zsh)
PLUGINS_DIR=${ZSH_PLUGINS_DIR:-"$HOME/.zsh/plugins"}

if [ -d "$PLUGINS_DIR" ] && [ -z "$FORCE" ]; then
    echo "Skipping download of zsh plugins, set FORCE=1 to force reinstall"
else
    echo "Installing zsh plugins to $PLUGINS_DIR..."
    rm -rf "$PLUGINS_DIR"
    mkdir -p "$PLUGINS_DIR"

    git clone https://github.com/romkatv/powerlevel10k.git \
        "${PLUGINS_DIR}/powerlevel10k"

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "${PLUGINS_DIR}/zsh-syntax-highlighting"

    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "${PLUGINS_DIR}/zsh-autosuggestions"

    git clone https://github.com/zsh-users/zsh-completions \
        "${PLUGINS_DIR}/zsh-completions"
fi
