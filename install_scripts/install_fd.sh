#! /bin/bash
set -euo pipefail
# install_nvim.sh <command> where comamnd is either release or nightly

url=$(curl -s https://api.github.com/repos/sharkdp/fd/releases/latest \
    | grep "browser_download_url.*fd_.*amd64.deb\"" \
    | cut -d : -f 2,3 \
    | tr -d \")

$DOT_DIR/install_scripts/install_deb.sh "$url" "fd"
