set tabstop=4
" " when indenting with '>', use 4 spaces width
set shiftwidth=4
" " On pressing tab, insert 4 spaces
set expandtab


"Getting python indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=0 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" numbering
set number norelativenumber

" :augroup numbertoggle
" :  autocmd!
" :  autocmd BufEnter,FocusGained,InsertLeave * if &filetype != 'nerdtree' && &filetype != 'tagbar' && &filetype != 'term'  | set relativenumber | endif
" :  autocmd BufLeave,FocusLost,InsertEnter * if &filetype != 'nerdtree' && &filetype != 'tagbar'  && &filetype != 'term' | set norelativenumber | endif
" :augroup END


let g:auto_save = 1  " enable AutoSave on Vim startup

source $HOME/git/dotfiles/vim/general/monkeyterminal.vim
source $HOME/git/dotfiles/vim/general/keys.vim
