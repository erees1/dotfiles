#! /bin/bash
set -euo pipefail
# install_nvim.sh <command> where comamnd is either release or nightly

release_version=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
    | grep "browser_download_url.*appimage\"" \
    | cut -d : -f 2,3 \
    | tr -d \")
nightly="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"

if [ "$1" == "nightly" ]; then
  url="$nightly" 
else
  url="$release_version"
fi

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
ln -sf ~/.local/nvim/squashfs-root/usr/bin/nvim ~/.local/bin/nvim
popd
