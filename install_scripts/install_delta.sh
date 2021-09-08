wget https://github.com/dandavison/delta/releases/download/0.4.4/git-delta_0.4.4_amd64.deb
dpkg -x git-delta_0.4.4_amd64.deb $HOME/.local/delta
ln -s $(readlink -f $HOME/.local/delta/usr/bin) $HOME/.local/bin
