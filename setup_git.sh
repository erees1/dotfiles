#!/usr/bin/env bash
# deploy.sh symlink dotfiles to your home directory

cd "$(dirname "$0")"
DOTFILES_ROOT=$(pwd -P)

. $DOTFILES_ROOT/utils/logging.sh

set -e

echo ''

setup_gitconfig () {
  if ! [ -f git/gitconfig.local ]
  then
    info 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.local.example > git/gitconfig.local

    success 'gitconfig'
  fi
}

setup_gitconfig
