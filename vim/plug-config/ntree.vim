" Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree

" Start NERDTree when Vim is started without file arguments.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 2 && !exists('s:std_in') | NERDTree | endif

" Start NERDTree when Vim starts with a directory argument.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
"     \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Start NERDTree. If a file is specified, move the cursor to its window.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Exit Vim if NERDTree is the only window left.
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    "\ quit | endif

" Refresh when entering nerd tree
" autocmd BufEnter NERD_tree_* | execute 'normal R'

let g:NERDTreeQuitOnOpen = 1
let nerdtreeshowlinenumbers=0

" ctrl-a to toggle nerdtree
nnoremap <C-a> :NERDTreeFocus<CR>
inoremap <C-a> <Esc> :NERDTreeFocus<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
