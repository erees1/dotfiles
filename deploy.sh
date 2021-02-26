#!/bin/bash

USAGE="Usage: ./deploy.sh local or ./deploy.sh remote"
if [ $# -eq 0 ]
  then
    echo "Error: No flags provided"
    echo $USAGE
    exit 1
fi

case "$1" in
    -h|--help)
    echo $USAGE
    exit
  ;;
esac

# set positional arguments in their proper place
PARAMS=$1

if [ $PARAMS == "local" ] || [ $PARAMS == "remote" ] || [ $PARAMS == "ucl" ] ; then
    
    # Tmux setup
    echo "source $HOME/git/dotfiles/config/tmux.conf" > $HOME/.tmux.conf

    # Vim / Neovim setup
    source "$HOME/git/dotfiles/vim/setup_vimrc.sh"

    # zshrc setup
    source "$HOME/git/dotfiles/zsh/setup_zshrc.sh"

else
    echo "Error: Unsupported flags provided"
    echo $USAGE
    exit 1
fi
