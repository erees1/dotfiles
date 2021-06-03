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
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" I'm now going to be experimenting with built in lsp instead of coc
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
Plug 'sbdchd/neoformat'

" Shortcuts etc
Plug 'zhou13/vim-easyescape'
Plug 'liuchengxu/vim-which-key'
Plug '907th/vim-auto-save'
Plug 'preservim/nerdcommenter'

" File navigation 
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Themes
Plug 'tjdevries/colorbuddy.nvim'
Plug 'erees1/onebuddy'

" Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update Plug 

" Nvim tree / explorer stuff
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Appearance
" Plug 'romgrk/barbar.nvim'  " tab bar at the top
Plug 'hoob3rt/lualine.nvim'  " bar at the bottom
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'lewis6991/gitsigns.nvim'
Plug 'norcalli/nvim-colorizer.lua'  " Highlight colors in that color

" Langauge specific
Plug 'lervag/vimtex'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'ojroques/vim-oscyank'

call plug#end()

" Plugin specific settings - I keep these all in plug-config directory
source $HOME/git/dotfiles/vim/plug-config/lspconfig.vim
source $HOME/git/dotfiles/vim/plug-config/compe.vim
source $HOME/git/dotfiles/vim/plug-config/neoformat.vim
source $HOME/git/dotfiles/vim/plug-config/nv-tree.vim
source $HOME/git/dotfiles/vim/plug-config/latex.vim
source $HOME/git/dotfiles/vim/plug-config/markdown-preview.vim
source $HOME/git/dotfiles/vim/plug-config/commenter.vim
source $HOME/git/dotfiles/vim/plug-config/whichkey.vim
source $HOME/git/dotfiles/vim/plug-config/barbar.vim
source $HOME/git/dotfiles/vim/plug-config/easy-escape.vim
source $HOME/git/dotfiles/vim/plug-config/pydocstring.vim
source $HOME/git/dotfiles/vim/plug-config/treesitter.vim
source $HOME/git/dotfiles/vim/plug-config/lualine.vim
source $HOME/git/dotfiles/vim/plug-config/telescope.vim
source $HOME/git/dotfiles/vim/plug-config/gitsigns.vim
source $HOME/git/dotfiles/vim/plug-config/colorizer.vim

