 vim.api.nvim_command([[
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif
]])
 vim.api.nvim_command([[
autocmd TextYankPost * if v:event.operator is 'x' && v:event.regname is '+' | OSCYankReg + | endif
]])
vim.api.nvim_command([[

function! YankNameToOsc()
let @+ = expand('%:p')
OSCYankReg +
endfunction
]])
vim.api.nvim_set_keymap('n', '<leader>cp' , ':call YankNameToOsc()<CR>', {noremap=true, silent=true })

