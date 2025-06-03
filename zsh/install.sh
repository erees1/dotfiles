#!/bin/bash
SRC_DIR=$(dirname "$0")

# zsh plugins use value of ZSH_PLUGIN_DIR if it exists (set in env.zsh)
PLUGINS_DIR=${ZSH_PLUGIN_DIR:-"$HOME/.zsh/plugins"}

if [ -d $PLUGINS_DIR ] && [ -z "$FORCE" ]; then
    echo "Skipping download of oh-my-zsh and related plugins, set FORCE=1 to force install"
else
    rm -rf $PLUGINS_DIR

    git clone https://github.com/romkatv/powerlevel10k.git \
        ${PLUGINS_DIR}/powerlevel10k 

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${PLUGINS_DIR}/zsh-syntax-highlighting 

    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${PLUGINS_DIR}/zsh-autosuggestions 

    git clone https://github.com/zsh-users/zsh-completions \
        ${PLUGINS_DIR}/zsh-completions 

    # git clone https://github.com/zsh-users/zsh-history-substring-search \
    #     ${PLUGINS_DIR}/zsh-history-substring-search 

    # git clone https://github.com/Aloxaf/fzf-tab \
    #     ${PLUGINS_DIR}/fzf-tab
fi


# System tools / utilities
if [ "$(uname -s)" = "Darwin" ]; then
  brew install fzf --no-zsh
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
