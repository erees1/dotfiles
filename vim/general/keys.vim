" Key Mappings


" ctr-p for fuzzy file search
nnoremap <C-p> :FZF<Cr>

" ctrl-a to toggle nerdtree
nnoremap <C-a> :NERDTreeFocus<CR>
inoremap <C-a> <Esc> :NERDTreeFocus<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

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

" ctr-p for fuzzy file search
nnoremap <C-p> :FZF<Cr>

" ctrl-a to toggle nerdtree
nmap <C-a> :NERDTreeFocus<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

" alias to insert a ipython style breakpoint
:ia ipydb import IPython ; IPython.embed() ; exit(1)<CR>

" ctrl-l to clear highlighing after search
nnoremap <silent> <C-l> :nohl<CR><C-l>
