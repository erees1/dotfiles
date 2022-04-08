#! /bin/bash
set -euo pipefail

rm -rf $HOME/.local/delta $HOME/.local/bin/delta
url="https://github.com/dandavison/delta/releases/download/0.4.4/git-delta_0.4.4_amd64.deb"

$DOT_DIR/install_scripts/install_deb.sh "$url" "delta"
