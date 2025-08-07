#!/bin/bash
set -euo pipefail

echo "Installing Neovim and language servers..."

# Install Neovim
brew install neovim

# Install ripgrep (required for many nvim plugins)
brew install ripgrep

# Install language servers
echo "Installing language servers..."

# Install Node.js via nvm if not already installed
if ! command -v node &>/dev/null; then
    echo "Node not found, please run 'nvm install --lts' after installation"
else
    # Install pyright language server
    npm install -g pyright
fi

echo "Neovim installation complete"
