" With this function you can reuse the same terminal in neovim.
" You can toggle the terminal and also send a command to the same terminal.

let s:monkey_terminal_window = -1
let s:monkey_terminal_buffer = -1
let s:monkey_terminal_job_id = -1
let s:prev_window = -1

function! MonkeyTerminalOpen(loc)
  " Check if buffer exists, if not create a window and a buffer
  if !bufexists(s:monkey_terminal_buffer)
    " Creates a window call monkey_terminal
    new monkey_terminal

    " Moves to the window the right the current one
    if a:loc == 'v' 
      wincmd J
      resize 12
    else
      wincmd L
      vertical resize -20
      resize 
    endif
    set nonumber
    set norelativenumber
    set signcolumn=no
    let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })
    startinsert!
     " Change the name of the buffer to "Terminal 1"
     silent file Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
     let s:monkey_terminal_buffer = bufnr('%')

    " The buffer of the terminal won't appear in the list of the buffers
    " when calling :buffers command
    set nobuflisted
  else
    if !win_gotoid(s:monkey_terminal_window)
    sp
    " Moves to the window below the current one
    if a:loc == 'v'
      wincmd J
      resize 12
    else
      wincmd L
      vertical resize -20
    endif
    set nonumber
    set norelativenumber
    set signcolumn=no
    buffer Terminal\ 1
    startinsert!
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
    endif
  endif
endfunction

function! MonkeyTerminalToggle(loc)
  if win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalClose()
    call win_gotoid(s:prev_window)
  else
    let s:prev_window = win_getid()
    call MonkeyTerminalOpen(a:loc)
  endif
endfunction

function! MonkeyTerminalClose()
  if win_gotoid(s:monkey_terminal_window)
    " close the current window
    hide
  endif
endfunction

function! MonkeyTerminalExec(cmd)
  if !win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalOpen()
  endif

  " clear current input
  call jobsend(s:monkey_terminal_job_id, "clear\n")

  " run cmd
  call jobsend(s:monkey_terminal_job_id, a:cmd . "\n")
  normal! G
  wincmd p
endfunction

" With this maps you can now toggle the terminal
nnoremap <silent> <F7> :call MonkeyTerminalToggle('v')<cr>
nnoremap <silent> <F8> :call MonkeyTerminalToggle('h')<cr>
inoremap <silent> <F7> <Esc> :call MonkeyTerminalToggle('v')<cr>
inoremap <silent> <F8> <Esc> :call MonkeyTerminalToggle('h')<cr>
tnoremap <silent> <F7> <C-\><C-n>:call MonkeyTerminalToggle('v')<cr>
tnoremap <silent> <F8> <C-\><C-n>:call MonkeyTerminalToggle('v')<cr>
tnoremap <Esc> <C-\><C-n><cr>

" This an example on how specify command with different types of files.
" augroup py
    " autocmd!
    " autocmd BufRead,BufNewFile *.py set filetype=py
    " autocmd FileType py nnoremap <F5> :call MonkeyTerminalExec('python ' . expand('%'))<cr>
" augroup END



" autocmd QuitPre * call <sid>MonkeyTerminalClose()
