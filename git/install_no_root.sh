#! /bin/bash
set -euo pipefail
SRC_DIR=$(dirname "$0")

rm -rf $HOME/.local/delta
url="https://github.com/dandavison/delta/releases/download/0.4.4/git-delta_0.4.4_amd64.deb"

$SRC_DIR/../utils/install_deb.sh "$url" "delta"
