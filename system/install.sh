#! /usr/bin/env zsh
SRC_DIR=$(dirname "$0")

# System tools / utilities
if [ "$(uname -s)" = "Darwin" ]; then
  brew install fzf
  brew install htop
  # if env variable extra set
  if [ -n "$EXTRA" ]; then    
    brew install bat
  fi
  $(brew --prefix)/opt/fzf/install --all
else
  if [ -z "$NO_ROOT" ]; then
    sudo apt install htop
    sudo apt install unzip
  fi

  # fd
  url=$(curl -s https://api.github.com/repos/sharkdp/fd/releases/latest \
      | grep "browser_download_url.*fd_.*amd64.deb\"" \
      | cut -d : -f 2,3 \
      | tr -d \")

  $SRC_DIR/../utils/install_deb.sh "$url" "fd"


  # FZF
  rm -rf $HOME/.fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  $HOME/.fzf/install --all
fi
