#!/bin/bash

USAGE="Usage: ./install.sh or ./install.sh --noroot"
if [ 1 == 0 ]
  then
    echo "Error: No flags provided"
    echo $USAGE
    exit 1
fi

zsh=true
tmux=false
root_access=true
PARAMS=""
while (( "$#" )); do
  case "$1" in
    -h|--help)
      echo $USAGE
      exit
      ;;
    --noroot)
      root_access=false
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

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [ $machine == "Linux" ]; then
    if [ root_access == true ]; then
        sudo apt-get install zsh
        sudo apt-get install tmux
        chsh -s $(which zsh | awk 'NR==1{print $3}')
    elif [ $root_access == false ]; then
        # Then we need to install from source
        if [[ $(which zsh) != *"bin/zsh"* ]]; then
            source $HOME/git/dotfiles/install_scripts/install_zsh.sh
        fi
    fi
elif [ $machine == "Mac" ]; then
    brew install zsh
    brew install tmux
    chsh -s /usr/local/bin/zsh
fi



sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
