 vim.api.nvim_command([[
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankRegister +' | endif
]])
 vim.api.nvim_command([[
autocmd TextYankPost * if v:event.operator is 'x' && v:event.regname is '+' | execute 'OSCYankRegister +' | endif
]])

vim.api.nvim_command([[
function! YankFullPathToOsc()
let @+ = expand('%:p')
OSCYankRegister +
endfunction

function! YankRelativePathToOsc()
let @+ = expand('%:.')
OSCYankRegister +
endfunction
]])

vim.api.nvim_set_keymap('n', '<leader>yr' , ':call YankRelativePathToOsc()<CR>', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>yf' , ':call YankFullPathToOsc()<CR>', {noremap=true, silent=true })

