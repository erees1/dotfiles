" Key Mappings

" Note this is not all key mappings, generally ones specific to a plugin 
" are in the plug-config folder

" Set space as leader
nnoremap <SPACE> <Nop>
let mapleader=" "

" Leader s to save
noremap <Leader>s :update<CR>

" ctr-p for fuzzy file search
function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

nnoremap <silent> <C-p> :call FZFOpen(':Files')<CR>

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Move lines up and down
if (has("nvim"))
	nnoremap <A-j> :m .+1<CR>==
	nnoremap <A-k> :m .-2<CR>==
	inoremap <A-j> :m .+1<CR>==gi
	inoremap <A-k> :m .-2<CR>==gi
	vnoremap <A-j> :m '>+1<CR>gv=gv
	vnoremap <A-k> :m '<-2<CR>gv=gv
	nnoremap <A-Down> :m .+1<CR>==
	nnoremap <A-Up> :m .-2<CR>==
	inoremap <A-Down> :m .+1<CR>==gi
	inoremap <A-UP> :m .-2<CR>==gi
	vnoremap <A-Down> :m '>+1<CR>gv=gv
	vnoremap <A-UP> :m '<-2<CR>gv=gv
else
	execute "set <M-j>=\ej"
	execute "set <M-k>=\ek"
	nnoremap <M-j> :m .+1<CR>==
	nnoremap <M-k> :m .-2<CR>==
	inoremap <M-j> :m .+1<CR>==gi
	inoremap <M-k> :m .-2<CR>==gi
	vnoremap <M-j> :m '>+1<CR>gv=gv
	vnoremap <M-k> :m '<-2<CR>gv=gv
endif

" Always use g mode
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
nnoremap <Up> gk
nnoremap g<Up> k 
nnoremap <Down> gj
nnoremap g<Down> j 

" Don't cut - delete when using d or c, x will still cut
nnoremap d "_d
nnoremap c "_c
vnoremap d "_d
vnoremap c "_c

" Move left and right with ctrl-h, ctrl-l
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" If you want to cut use the leader
nnoremap <leader>d ""d
nnoremap <leader>dd ""dd
nnoremap <leader>D ""D
vnoremap <leader>d ""d

" Shortcuts for forward deletion in insert mode
inoremap <C-f> <esc>lce

" ctr-p for fuzzy file search
nnoremap <C-p> :FZF<Cr>

" alias to insert a ipython style breakpoint
:ia ipydb import IPython ; IPython.embed() ; exit(1)<CR>

" ctrl-l to clear highlighing after search
" nnoremap <silent> <C-l> :nohl<CR><C-l>
nnoremap <Leader><space> :noh<cr>
