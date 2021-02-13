" Key Mappings


" ctr-p for fuzzy file search
nnoremap <C-p> :FZF<Cr>

" ctrl-a to toggle nerdtree
nmap <C-a> :NERDTreeFocus<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

" Move lines up and down
if (has("nvim"))
	nnoremap <A-j> :m .+1<CR>==
	nnoremap <A-k> :m .-2<CR>==
	inoremap <A-j> :m .+1<CR>==gi
	inoremap <A-k> :m .-2<CR>==gi
	vnoremap <A-j> :m '>+1<CR>gv=gv
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

" ctr-p for fuzzy file search
nnoremap <C-p> :FZF<Cr>

" ctrl-a to toggle nerdtree
nmap <C-a> :NERDTreeFocus<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
