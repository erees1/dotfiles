" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'

" auto-install vim plug                                                                                                                
let autoload_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(autoload_plug_path)                                                                                    
  echo 'Downloading vim plug'
  silent execute '!curl -fLo ' . autoload_plug_path . ' --create-dirs
        \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall
endif                                                                                                                                 
unlet autoload_plug_path

call plug#begin('~/.config/nvim/plugged')


" Stuff for completion / code
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }

" Shortcuts etc
Plug 'zhou13/vim-easyescape'
Plug 'liuchengxu/vim-which-key'
Plug '907th/vim-auto-save'
Plug 'preservim/nerdcommenter'

" File navigation 
" Plug 'francoiscabrol/ranger.vim'
" Plug 'rbgrouleff/bclose.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Themes
Plug 'folke/tokyonight.nvim'
Plug 'erees1/vim-one'

Plug 'machakann/vim-highlightedyank'

" Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update Plug 

" Nerdtree stuff
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Appearance
Plug 'romgrk/barbar.nvim'  " tab bar at the top
Plug 'hoob3rt/lualine.nvim'  " bar at the bottom
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Langauge specific
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}


call plug#end()

