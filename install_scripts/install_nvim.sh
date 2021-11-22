#! /bin/bash
set -euo pipefail
# install_nvim.sh <url> where url is an optional url

release_version="https://github.com/neovim/neovim/releases/download/v0.5.1/nvim.appimage"
nightly="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"

if [ "$#" -lt 1 ]; then
  url=$nightly # YEAH BUDDY!
else
  url=$1
fi

# Nfs hangs so mv before deleting
mv ~/.local/nvim .nvim.old && rm -rf .nvim.old
mkdir -p ~/.local/nvim && cd ~/.local/nvim
wget $url
chmod u+x ./nvim.appimage
./nvim.appimage --appimage-extract
ln -sf ~/.local/nvim/squashfs-root/usr/bin/nvim ~/.local/bin/nvim
