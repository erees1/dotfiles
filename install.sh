#!/bin/bash
set -euo pipefail

echo "Starting dotfiles installation for macOS..."

read -p "This will install dotfiles and dependencies. Continue? (y/n): " choice
if [[ ! $choice =~ ^[Yy]$ ]]; then
    echo "Installation cancelled"
    exit 0
fi

echo "Installing Homebrew packages..."
brew install coreutils
brew install tmux
brew install fzf
brew install htop
brew install ripgrep
brew install git-delta
brew install openssl readline sqlite3 xz zlib tcl-tk
brew install pyenv
brew install pyenv-virtualenv
brew install nvm

echo "Installing zsh plugins..."
./zsh/install_plugins.sh

echo "Installing Neovim..."
./nvim/install.sh

echo "Setting macOS defaults..."
./osx/set_defaults.sh

echo "Installation complete!"
echo "Please restart your terminal or run 'source ~/.zshrc' to apply changes"
