#!/bin/bash
set -euo pipefail

# Simple Mac-only installer for dotfiles
# Installs all dependencies directly without complex logic

echo "Starting dotfiles installation for macOS..."

# Check if running on macOS
if [ "$(uname -s)" != "Darwin" ]; then
    echo "Error: This installer is macOS only"
    exit 1
fi

read -p "This will install dotfiles and dependencies. Continue? (y/n): " choice
if [[ ! $choice =~ ^[Yy]$ ]]; then
    echo "Installation cancelled"
    exit 0
fi

echo "Installing Homebrew packages..."

# Core utilities
brew install coreutils

# Terminal tools
brew install tmux
brew install fzf
brew install htop
brew install ripgrep

# Git tools
brew install git-delta

# Python environment
brew install openssl readline sqlite3 xz zlib tcl-tk
brew install pyenv
brew install pyenv-virtualenv

# Node (for LSPs and tools)
brew install nvm
mkdir -p ~/.nvm

# Optional tools (uncomment if wanted)
# brew install bat

echo "Installing tmux plugin manager..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Installing zsh plugins..."
./zsh/install.sh

echo "Installing Neovim..."
./nvim/install.sh

echo "Setting macOS defaults..."
./osx/set_defaults.sh

echo "Installation complete!"
echo "Please restart your terminal or run 'source ~/.zshrc' to apply changes"
