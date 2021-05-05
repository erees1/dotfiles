
" Set space as leader
nnoremap <SPACE> <Nop>
let mapleader=" "

" General Settings
source $HOME/git/dotfiles/vim/general/general.vim
source $HOME/git/dotfiles/vim/general/monkeyterminal.vim

if exists('g:vscode')
  source $HOME/git/dotfiles/vim/general/vscode.vim
else
  " Plugins
  source $HOME/git/dotfiles/vim/plugins.vim

  " Filetype specific behaviour
  " source $HOME/git/dotfiles/vim/ft/tex.vim
  " source $HOME/git/dotfiles/vim/ft/python.vim

  " Themes
  source $HOME/git/dotfiles/vim/themes/theme.vim
endif

source $HOME/git/dotfiles/vim/general/keys.vim

