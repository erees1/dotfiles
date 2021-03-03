 
" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Exit Vim if NERDTree is the only window left.
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    "\ quit | endif

" Refresh when entering nerd tree
" autocmd BufEnter NERD_tree_* | execute 'normal R'

let nerdtreeshowlinenumbers=0

" ctrl-shift-a to toggle nerdtree
nnoremap <C-S-a> :NERDTreeFocus<CR>
inoremap <C-S-a> <Esc> :NERDTreeFocus<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
