#!/bin/bash

echo "deploying on $LOC machine..."
echo "source $HOME/git/dotfiles/zsh/common/zshrc.sh" > $HOME/.zshrc
echo "source $HOME/git/dotfiles/zsh/$LOC/zshrc.sh" >> $HOME/.zshrc

# Relaunch zsh
# zsh
