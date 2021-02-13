" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Fuzzy finding

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'preservim/nerdtree'

Plug 'joshdick/onedark.vim'

Plug 'sheerun/vim-polyglot'

Plug 'ryanoasis/vim-devicons'

call plug#end()

" Source plugin specific settings
source $HOME/git/dotfiles/vim/plug-config/coc.vim
source $HOME/git/dotfiles/vim/plug-config/ntree.vim





