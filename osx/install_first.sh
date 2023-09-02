#!/bin/bash
SRC_DIR=$(dirname "$0")

brew install coreutils

# Mac OS defaults
$SRC_DIR/set_defaults.sh