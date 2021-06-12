#! /bin/bash
set -euo pipefail

USAGE="install_nvim.sh <url>"

if [ "$#" -lt 1 ]; then
  echo $USAGE
  exit 1
fi

rm -rf ~/.local/nvim
mkdir -p ~/.local/nvim
cd ~/.local/nvim
wget $1
chmod u+x ./nvim.appimage
./nvim.appimage --appimage-extract
ln -sf ~/.local/nvim/squashfs-root/usr/bin/nvim ~/.local/bin/nvim
