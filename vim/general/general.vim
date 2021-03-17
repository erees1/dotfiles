set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab

:set wrap linebreak nolist

"Getting python indentation
au BufNewFile,BufRead *.py \ set tabstop=4 | \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=0 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" numbering
set number norelativenumber

let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_events = ["InsertLeave"]

" Copy to cliboard by default
set clipboard+=unnamedplus

:hi NonText guifg=bg

