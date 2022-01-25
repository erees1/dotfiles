 vim.api.nvim_command([[
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif
]])
 vim.api.nvim_command([[
autocmd TextYankPost * if v:event.operator is 'x' && v:event.regname is '+' | OSCYankReg + | endif
]])

vim.api.nvim_command([[
function! YankFullPathToOsc()
let @+ = expand('%:p')
OSCYankReg +
endfunction

function! YankRelativePathToOsc()
let @+ = expand('%:.')
OSCYankReg +
endfunction
]])

vim.api.nvim_set_keymap('n', '<leader>gf' , ':call YankRelativePathToOsc()<CR>', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>gff' , ':call YankFullPathToOsc()<CR>', {noremap=true, silent=true })
