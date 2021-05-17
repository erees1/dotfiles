#!/bin/bash
set -euo pipefail
USAGE=$(cat <<-END
    Usage: ./install.sh [p1] [p2]
    where p1, p2 are from the following options:
    tmux, pyenv, kitty, zsh (they wont all work on linux) 
    optional flag --noroot does not use sudo when on linux 
END
)

root_access=true
PARAMS=""
while (( "$#" )); do
  case "$1" in
    -h|--help)
      echo "$USAGE"
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
pyenv=false
kitty=false
if [[ " ${PARAMS[@]} " =~ " zsh " ]]; then
 zsh=true 
fi
if [[ " ${PARAMS[@]} " =~ " tmux " ]]; then
 tmux=true 
fi
if [[ " ${PARAMS[@]} " =~ " pyenv " ]]; then
 pyenv=true 
fi
if [[ " ${PARAMS[@]} " =~ " kitty " ]]; then
 kitty=true 
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
  brew install wget
  brew install node # Node required for coc
    if [ $zsh == true ]; then
      brew install zsh
    fi
    if [ $tmux == true ]; then
      brew install tmux
    fi
    if [ $pyenv == true ]; then
      brew install pyenv
    fi
    if [ $kitty == true ]; then
      brew install --cask kitty
    fi
fi

# Setting up oh my zsh and oh my zsh plugins
ZSH=~/.oh-my-zsh
ZSH_CUSTOM=$ZSH/custom
if [[ -d $ZSH ]]; then
  echo "Skipping download of oh-my-zsh and related plugins, remove $ZSH to force"
else
  echo "------------------------------------------------------------"
  echo "You will need to ctrl-d out of the next step as install oh-my-zsh spawns a new zsh shell"
  echo "------------------------------------------------------------"
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  rm -f ~/.zshrc.pre-*
  git clone https://github.com/romkatv/powerlevel10k.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k 
  git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 
  git clone --quiet https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 
  git clone --quiet https://github.com/zsh-users/zsh-completions \
    ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions 
  git clone  --quiet https://github.com/zsh-users/zsh-history-substring-search \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search 
fi

if [[ ! -d ~/.tmux-themepack ]]; then
  git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
fi

echo " --------- INSTALLED SUCCESSFULLY ----------- "
