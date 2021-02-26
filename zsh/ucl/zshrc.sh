
# source standard remote files
source $HOME/git/dotfiles/zsh/remote/zshrc.sh

# We need this moudle function
module() {
    eval `/shared/ucl/apps/modules/3.2.6/Modules/$MODULE_VERSION/bin/modulecmd bash $*`
}
