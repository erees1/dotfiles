if [ "$(uname -s)" == "Darwin" ]
then
  brew install rbenv
  eval "$(rbenv init -)"
  rbenv install 2.7.2
  rbenv global 2.7.2
fi
