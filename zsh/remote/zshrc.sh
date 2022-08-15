ZSH_DOT_DIR=$(dirname $(realpath ${(%):-%x}))/..

. $ZSH_DOT_DIR/utils.sh
. $ZSH_DOT_DIR/../install_scripts/util.sh

export PYENV_ROOT="$HOME/.pyenv/bin"

export PYENV_ROOT="$HOME/.pyenv/bin"
add_to_path $PYENV_ROOT
add_to_path "$MY_BIN_LOC"

# Must source dir_colors first as picked up by plugins in common
source $ZSH_DOT_DIR/common/zshrc.sh
source $ZSH_DOT_DIR/remote/aliases.sh
