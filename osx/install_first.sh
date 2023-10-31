#!/bin/bash
set -euo pipefail
SRC_DIR=$(dirname "$0")

if [ "$(uname -s)" == "Darwin" ]
then
    brew install coreutils

    # Mac OS defaults
    $SRC_DIR/set_defaults.sh
fi
