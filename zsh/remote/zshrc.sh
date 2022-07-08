ZSH_DOT_DIR=$(dirname $(realpath ${(%):-%x}))/..

. $ZSH_DOT_DIR/utils.sh

export PYENV_ROOT="$HOME/.pyenv/bin"

add_to_path $PYENV_ROOT

# Must source dir_colors first as picked up by plugins in common
source $ZSH_DOT_DIR/common/zshrc.sh
source $ZSH_DOT_DIR/remote/aliases.sh
