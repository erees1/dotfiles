ZSH_DOT_DIR=$(dirname $(realpath ${(%):-%x}))/..

. $ZSH_DOT_DIR/utils.sh
. $ZSH_DOT_DIR/../install_scripts/util.sh

export LOC="remote"

export PYENV_ROOT="$HOME/.pyenv/bin"
add_to_path $PYENV_ROOT
add_to_path "$MY_BIN_LOC"
add_to_path "${HOME}/.npm-global/bin"

. $ZSH_DOT_DIR/common/zshrc.sh
. $ZSH_DOT_DIR/remote/aliases.sh
