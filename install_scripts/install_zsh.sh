#!/bin/bash
# Script to install zsh from source, (i.e. no root access)

cd && mkdir zsh && cd zsh
wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download
unxz zsh.tar.xz  && tar -xvf zsh.tar && rm -rf zsh.tar
cd zsh-*
./configure -prefix=$HOME/.local
make && make install
