#! /bin/bash -eu
set -euo pipefail
SRC_DIR=$(dirname "$0")
# Helper script to download and install .debs in .local/bin

url=$1
name=$2

tmp_dir="$HOME/.local/tmp-deb-download" 
mkdir -p $tmp_dir
pushd $tmp_dir
wget $url
file=$(find ./ -name '*.deb')
echo $file
dpkg -x $file $HOME/.local/$name
rm -rf $tmp_dir

mkdir -p $MY_BIN_LOC
ln -sf $(readlink -f $HOME/.local/$name/usr/bin/$name) $MY_BIN_LOC/$name
