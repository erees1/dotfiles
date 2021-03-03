" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" F5 to run show markwon preview 
autocmd FileType markdown nnoremap <F5> :MarkdownPreview<cr>
