" Key Mappings

" Note this is not all key mappings, generally ones specific to a plugin 
" are in the plug-config folder


" Leader s to save
noremap <Leader>s :update<CR>


" Always use g mode
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
nnoremap <Up> gk
nnoremap g<Up> k 
nnoremap <Down> gj
nnoremap g<Down> j 

" esc in insert mode
inoremap jk  <esc>

" Move lines up and down
if (has("nvim"))
	nnoremap <silent> <A-j> :m .+1<CR>==
	nnoremap <silent> <A-k> :m .-2<CR>==
	inoremap <silent> <A-j> :m .+1<CR>==gi
	inoremap <silent> <A-k> :m .-2<CR>==gi
	vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
	vnoremap <silent> <A-k> :m '<-2<CR>gv=gv
	nnoremap <silent> <A-Down> :m .+1<CR>==
	nnoremap <silent> <A-Up> :m .-2<CR>==
	inoremap <silent> <A-Down> :m .+1<CR>==gi
	inoremap <silent> <A-UP> :m .-2<CR>==gi
	vnoremap <silent> <A-Down> :m '>+1<CR>gv=gv
	vnoremap <silent> <A-UP> :m '<-2<CR>gv=gv
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


" Don't cut - delete when using d or c, x will still cut
nnoremap d "_d
nnoremap c "_c
vnoremap d "_d
vnoremap c "_c

" If you want to cut use the leader
nnoremap <leader>d ""d
nnoremap <leader>dd ""dd
nnoremap <leader>D ""D
vnoremap <leader>d ""d

" Quick fix navigation
nnoremap <M-n> :cn<CR>
nnoremap <M-p> :cp<CR>

" Shortcuts for forward deletion in insert mode
inoremap <C-f> <esc>lce

" alias to insert a ipython style breakpoint
:ia ipydb import IPython ; IPython.embed() ; exit(1)<CR>

" <leader><space> to clear highlighing after search
nnoremap <Leader><space> :noh<cr>
