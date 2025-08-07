echo "Setting macOS defaults..."
./osx/set_defaults.sh
echo "Installing Homebrew packages..."
brew install coreutils
brew install fzf
brew install bat
brew install git-delta

echo "Installing zsh plugins..."
./zsh/install_plugins.sh
