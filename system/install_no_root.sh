#!/bin/bash -eux
. $DOT_DIR/install_scripts/util.sh

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

$DOT_DIR/install_scripts/install_deb.sh "$url" "fd"
