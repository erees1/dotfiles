#!/bin/bash
set -euo pipefail

USAGE="Usage: ./deploy.sh local or ./deploy.sh remote, optional flag --terminfo to compile kitty terminfo"
if [ $# -eq 0 ]
  then
    echo "Error: No flags provided"
    echo $USAGE
    exit 1
fi

terminfo=false
PARAMS=""
while (( "$#" )); do
  case "$1" in
    -h|--help)
      echo $USAGE
      exit
      ;;
    --terminfo)
      terminfo=true
      shift
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"
PARAMS=($PARAMS)
LOC=${PARAMS[0]}

# Set any variables
if [ $LOC == "local" ] || [ $LOC == "remote" ] ; then

    # Tmux setup
    echo "source $HOME/git/dotfiles/tmux/tmux.conf" > $HOME/.tmux.conf

    # Vim / Neovim setup
    source "$HOME/git/dotfiles/vim/setup_init.sh"

    # zshrc setup
    source "$HOME/git/dotfiles/zsh/setup_zshrc.sh"

    # Gitconfig setup
    source "$HOME/git/dotfiles/gitconf/setup_gitconfig.sh"
    
else
    echo "Error: Unsupported flags provided"
    echo $USAGE
    exit 1
fi
zsh
