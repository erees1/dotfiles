#!/bin/bash
SRC_DIR=$(dirname "$0")

if [ "$(uname -s)" == "Darwin" ]
then
    brew install nvim
    # Ensure vim language servers are installed
    brew install ripgrep
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
fi
