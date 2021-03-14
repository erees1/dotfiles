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
LOC=$PARAMS

if [ $PARAMS == "local" ] || [ $PARAMS == "remote" ] || [ $PARAMS == "ucl" ] ; then
   

    # Tmux setup
    echo "source $HOME/git/dotfiles/tmux/tmux.conf" > $HOME/.tmux.conf

    # Alacritty setup
    ln -sf "$HOME/git/dotfiles/alacritty/config.yml" "$HOME/.config/alacritty.yml"

    # Kitty setup
    source "$HOME/git/dotfiles/kitty/setup_kitty.sh"

    # Vim / Neovim setup
    source "$HOME/git/dotfiles/vim/setup_vimrc.sh"

    # zshrc setup
    source "$HOME/git/dotfiles/zsh/setup_zshrc.sh"

else
    echo "Error: Unsupported flags provided"
    echo $USAGE
    exit 1
fi
zsh
