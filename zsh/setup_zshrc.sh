echo "deploying on $PARAMS machine..."
echo "source $HOME/git/dotfiles/zsh/common/zshrc.sh" > $HOME/.zshrc
echo "source $HOME/git/dotfiles/zsh/$PARAMS/zshrc.sh" >> $HOME/.zshrc

# Relaunch zsh
zsh
