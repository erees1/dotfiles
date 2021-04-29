
" General Settings
source $HOME/git/dotfiles/vim/general/general.vim
source $HOME/git/dotfiles/vim/general/keys.vim
source $HOME/git/dotfiles/vim/general/monkeyterminal.vim

if exists('g:vscode')
  source $HOME/git/dotfiles/vim/general/vscode.vim
else
  " Plugins
  source $HOME/git/dotfiles/vim/plug-config/plugins.vim
  " Plugin specific settings
  source $HOME/git/dotfiles/vim/plug-config/coc.vim
  source $HOME/git/dotfiles/vim/plug-config/nv-tree.vim
  source $HOME/git/dotfiles/vim/plug-config/latex.vim
  source $HOME/git/dotfiles/vim/plug-config/markdown-preview.vim
  source $HOME/git/dotfiles/vim/plug-config/commenter.vim
  source $HOME/git/dotfiles/vim/plug-config/highlightedyank.vim
  source $HOME/git/dotfiles/vim/plug-config/whichkey.vim
  source $HOME/git/dotfiles/vim/plug-config/barbar.vim
  source $HOME/git/dotfiles/vim/plug-config/easy-escape.vim
  source $HOME/git/dotfiles/vim/plug-config/pydocstring.vim
  source $HOME/git/dotfiles/vim/plug-config/treesitter.vim
  source $HOME/git/dotfiles/vim/plug-config/lualine.vim

  " Filetype specific behaviour
  " source $HOME/git/dotfiles/vim/ft/tex.vim
  " source $HOME/git/dotfiles/vim/ft/python.vim

  " Themes
  source $HOME/git/dotfiles/vim/themes/theme.vim
endif
