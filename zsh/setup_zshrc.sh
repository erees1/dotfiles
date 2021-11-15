#!/bin/bash

DOT_FILES=$HOME/git/dotfiles

echo "deploying on $LOC machine..."
echo "source $DOT_FILES/zsh/$LOC/zshrc.sh" > $HOME/.zshrc
echo "source $DOT_FILES/zsh/common/zshrc.sh" >> $HOME/.zshrc

# Relaunch zsh
zsh
