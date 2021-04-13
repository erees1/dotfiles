
"Getting python indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=0 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

augroup ft_python
  au!
  au FileType python let b:auto_save_events = ["InsertLeave", "TextChanged"]
augroup END
