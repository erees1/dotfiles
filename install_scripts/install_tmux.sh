#!/bin/bash

cd && mkdir tmux && cd tmux
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure --prefix=$HOME/.local
make && make install
