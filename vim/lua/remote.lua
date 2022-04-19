 vim.api.nvim_command([[
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif
autocmd TextYankPost * if v:event.operator is 'x' && v:event.regname is '+' | OSCYankReg + | endif

function! YankFullPathToOsc()
    let @+ = expand('%:p')
    OSCYankReg +
endfunction

function! YankRelativePathToOsc()
    let @+ = expand('%:.')
    OSCYankReg +
endfunction
]])

remap('n', '<leader>yr' , ':call YankRelativePathToOsc()<CR>', {noremap=true, silent=true })
remap('n', '<leader>yf' , ':call YankFullPathToOsc()<CR>', {noremap=true, silent=true })
