SRC_DIR=$(dirname "$0")

if [ "$(uname -s)" == "Darwin" ]
then
  brew install git-delta
else
  $SRC_DIR/install_no_root.sh  
fi
