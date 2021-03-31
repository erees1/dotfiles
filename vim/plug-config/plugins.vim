" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'

" auto-install vim plug                                                                                                                
if empty(glob('~/.config/nvim/autoload/plug.vim'))                                                                                    
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim \
  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim                                                             
  autocmd VimEnter * PlugInstall                                                                                                      
endif                                                                                                                                 

call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Better tabline
Plug 'romgrk/barbar.nvim'

Plug 'liuchengxu/vim-which-key'

Plug 'kyazdani42/nvim-web-devicons' " for file icons

Plug 'kyazdani42/nvim-tree.lua'

Plug 'mhinz/vim-startify'

Plug 'erees1/vim-one'

Plug 'machakann/vim-highlightedyank'

Plug 'sheerun/vim-polyglot'

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'vim-airline/vim-airline'

Plug '907th/vim-auto-save'

Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'lervag/vimtex'

Plug 'preservim/nerdcommenter'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

call plug#end()

