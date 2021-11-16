ZSH_DOT_DIR=$(dirname $(realpath ${(%):-%x}))/..

# Must source dir_colors first as picked up by plugins in common
source $ZSH_DOT_DIR/remote/dir_colors.sh
source $ZSH_DOT_DIR/common/zshrc.sh
source $ZSH_DOT_DIR/remote/aliases.sh
