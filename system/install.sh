#! /usr/bin/env zsh
SRC_DIR=$(dirname "$0")

# System tools / utilities
if [ "$(uname -s)" = "Darwin" ]
then
  brew install exa
  brew install fzf
  brew install htop
  brew install bat
  $(brew --prefix)/opt/fzf/install --all
else
  if [ -z "$NO_ROOT" ]; then
    sudo apt install htop
    sudo apt install unzip
  fi

  # Exa
  if ! $(which $MY_BIN_LOC/exa); then
      (
          tmp_dir=$(mktemp -d -t exa-XXXXXXX) && cd $tmp_dir
          wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
          unzip exa-linux-x86_64-0.9.0.zip && chmod a+x exa-linux-x86_64
          cp exa-linux-x86_64 $MY_BIN_LOC/exa
          rm -rf $tmp_dir
      )
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
