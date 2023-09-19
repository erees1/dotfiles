if [ "$(uname -s)" == "Darwin" ]
then
  # as per https://github.com/pyenv/pyenv/wiki#how-to-build-cpython-with-framework-support-on-os-x
  brew install openssl readline sqlite3 xz zlib tcl-tk
  brew install pyenv
  brew install pyenv-virtualenv
fi