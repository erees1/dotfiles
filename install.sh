#!/bin/bash
set -euo pipefail

USAGE="Usage: ./install.sh [zsh] [tmux] or ./install.sh --noroot [zsh] [tmux]"

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
PARAMS=($PARAMS)


zsh=false
tmux=false
if [[ " ${PARAMS[@]} " =~ " zsh " ]]; then
 zsh=true 
fi
if [[ " ${PARAMS[@]} " =~ " tmux " ]]; then
 tmux=true 
fi

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# Installing on linux with apt
if [ $machine == "Linux" ]; then
  if [ $root_access == true ]; then
    if [ $zsh == true ]; then
        sudo apt-get install zsh
    fi
    if [ $tmux == true ]; then
        sudo apt-get install tmux 
    fi

  elif [ $root_access == false ]; then
    if [ $zsh == true ]; then
      # Then we need to install from source
      if [[ $(which zsh) != *"bin/zsh"* ]]; then
          source $HOME/git/dotfiles/install_scripts/install_zsh.sh
      fi
    fi
  fi

# Installing on mac with homebrew
elif [ $machine == "Mac" ]; then
    if [ $zsh == true ]; then
      brew install zsh
      chsh -s /usr/local/bin/zsh
    fi
    if [ $tmux == true ]; then
      brew install tmux
    fi
fi

# Setting up oh my zsh and oh my zsh plugins
# ZSH=~/opt/oh-my-zsh
# ZSH_CUSTOM=$ZSH/custom
rm -rf ${ZSH:-~/.oh-my-zsh}
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

rm -rf ~/.tmux-themepack
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack


echo " --------- INSTALLED SUCCESSFULLY ----------- "
