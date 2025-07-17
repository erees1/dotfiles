#!/bin/bash
SRC_DIR=$(dirname "$0")

if [ "$(uname -s)" == "Darwin" ]
then
    brew install nvim
    # Ensure vim language servers are installed
    brew install ripgrep
    # Install pyright language server
    brew install node  # pyright requires node
    npm install -g pyright
else
    release_version=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
        | grep "browser_download_url.*appimage\"" \
        | cut -d : -f 2,3 \
        | tr -d \")
    nightly="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"

    url="$release_version"
    # change to url="$nightly" to install the nightly version

    dir="$HOME/.local/nvim" 
    # Nfs hangs so mv before deleting
    if [ -d $dir ]; then
        mv $dir .nvim.old && rm -rf .nvim.old
    fi
    mkdir -p $dir
    pushd $dir
    wget $url
    chmod u+x ./nvim.appimage
    ./nvim.appimage --appimage-extract
    ln -sf ~/.local/nvim/squashfs-root/usr/bin/nvim $MY_BIN_LOC/nvim
    popd
    
    # Install language servers on Linux
    # Install Node.js if not present
    if ! command -v node &> /dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
        sudo apt-get install -y nodejs
    fi
    
    # Install pyright
    sudo npm install -g pyright
fi
