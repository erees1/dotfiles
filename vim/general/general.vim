set tabstop=4
" " when indenting with '>', use 4 spaces width
set shiftwidth=4
" " On pressing tab, insert 4 spaces
set expandtab

source $HOME/git/dotfiles/vim/general/keys.vim

"Getting python indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" numbering
set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * if &filetype != 'nerdtree' && &filetype != 'tagbar' | set relativenumber | endif
:  autocmd BufLeave,FocusLost,InsertEnter * if &filetype != 'nerdtree' && &filetype != 'tagbar' | set norelativenumber | endif
:augroup END
