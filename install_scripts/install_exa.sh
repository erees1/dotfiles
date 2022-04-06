#!/bin/bash -eux

if ! $(which $HOME/.local/bin/exa); then
    (
        tmp_dir=$(mktemp -d -t exa-XXXXXXX) && cd $tmp_dir
        wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
        unzip exa-linux-x86_64-0.9.0.zip && chmod a+x exa-linux-x86_64
        cp exa-linux-x86_64 $HOME/.local/bin/exa
        rm -rf $tmp_dir
    )
fi
