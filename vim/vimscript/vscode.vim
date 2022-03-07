"VSCode
function! s:manageEditorSize(...)
    let count = a:1
    let to = a:2
    for i in range(1, count ? count : 1)
        call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
    endfor
endfunction

" Better Navigation 
nnoremap <silent> <C-j> <Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> <Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k> <Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <C-k> <Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h> <Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> <Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l> <Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> <Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>

nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>

xmap <leader>gc  <Plug>VSCodeCommentary
omap <leader>gc  <Plug>VSCodeCommentary
nmap <leader>gc <Plug>VSCodeCommentaryLine

nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
nnoremap <leader>e <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
nnoremap <leader>tf <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
nnoremap <leader>s <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>
nnoremap <leader>q <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
nnoremap <leader>f <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>

nnoremap <leader>gf <Cmd>call VSCodeNotify('copyRelativeFilePath')<CR>:echo 'YANKED RELATIVE FILE PATH'<CR>
nnoremap <leader>gff <Cmd>call VSCodeNotify('copyFilePath')<CR>:echo 'YANKED FILE PATH'<CR>

nnoremap <leader>rn <Cmd>call VSCodeNotify('editor.action.rename')<CR>
vnoremap <leader>rn <Cmd>call VSCodeNotify('editor.action.rename')<CR>
nnoremap ∆ <Cmd>call VSCodeNotify('editor.action.moveLinesDownAction')j<CR>
nnoremap ˚ <Cmd>call VSCodeNotify('editor.action.moveLinesUpAction')k<CR>

" TODO this dosn't work due to interaction between vscode and nvim selection
vnoremap ∆ <Cmd>call VSCodeNotifyVisual('editor.action.moveLinesDownAction', 1)<CR>
vnoremap ˚ <Cmd>call VSCodeNotifyVisual('editor.action.moveLinesUpAction', 1)<CR>

nnoremap <leader>hn <Cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>
nnoremap <leader>hp <Cmd>call VSCodeNotify('git.timeline.openDiff')<CR>

"line indendation
vnoremap <S-,> <Cmd>call VSCodeNotify('editor.action.outdentLines')<CR>
vnoremap <S-.> <Cmd>call VSCodeNotify('editor.action.indentLines')<CR>
nnoremap <S-,> <Cmd>call VSCodeNotify('editor.action.outdentLines')<CR>
nnoremap <S-.> <Cmd>call VSCodeNotify('editor.action.indentLines')<CR>
nnoremap <leader>s <Cmd>call VSCodeNotify('workbench.action.files.save')<CR>

"Move through wrapped lines
nnoremap gk :<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
nnoremap gj :<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
