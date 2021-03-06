" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Fuzzy finding

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Better tabline
" Plug 'romgrk/barbar.nvim'

Plug 'mhinz/vim-startify'

Plug 'preservim/nerdtree'

Plug 'erees1/onedark.vim'

Plug 'machakann/vim-highlightedyank'

Plug 'rakr/vim-one'

Plug 'christianchiarulli/nvcode-color-schemes.vim'

Plug 'sheerun/vim-polyglot'

Plug 'ryanoasis/vim-devicons'

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'vim-airline/vim-airline'

Plug '907th/vim-auto-save'

Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'lervag/vimtex'

Plug 'preservim/nerdcommenter'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

" Source plugin specific settings
source $HOME/git/dotfiles/vim/plug-config/coc.vim
source $HOME/git/dotfiles/vim/plug-config/ntree.vim
source $HOME/git/dotfiles/vim/plug-config/airline.vim
source $HOME/git/dotfiles/vim/plug-config/latex.vim
source $HOME/git/dotfiles/vim/plug-config/markdown-preview.vim
source $HOME/git/dotfiles/vim/plug-config/commenter.vim
source $HOME/git/dotfiles/vim/plug-config/highlightedyank.vim
