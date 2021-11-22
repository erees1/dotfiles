#! /bin/bash
set -euo pipefail

rm -rf $HOME/.local/delta $HOME/.local/bin/delta
wget https://github.com/dandavison/delta/releases/download/0.4.4/git-delta_0.4.4_amd64.deb
dpkg -x git-delta_0.4.4_amd64.deb $HOME/.local/delta
rm git-delta_0.4.4_amd64.deb
ln -s $(readlink -f $HOME/.local/delta/usr/bin/delta) $HOME/.local/bin/delta
