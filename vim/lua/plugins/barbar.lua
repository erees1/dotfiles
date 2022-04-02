vim.api.nvim_set_keymap('n', '<A-,>', ':BufferPrevious<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<A-.>', ':BufferNext<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>q', ':BufferClose<CR>', { noremap=true, silent=true })

vim.cmd([[
function! ResetBarBarOffset()
    lua require('bufferline.state').set_offset(0)
endfunction
]])
