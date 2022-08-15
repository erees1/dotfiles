#!/bin/bash -eux
. $DOT_DIR/install_scripts/util.sh

if ! $(which $MY_BIN_LOC/exa); then
    (
        tmp_dir=$(mktemp -d -t exa-XXXXXXX) && cd $tmp_dir
        wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
        unzip exa-linux-x86_64-0.9.0.zip && chmod a+x exa-linux-x86_64
        cp exa-linux-x86_64 $MY_BIN_LOC/exa
        rm -rf $tmp_dir
    )
fi
