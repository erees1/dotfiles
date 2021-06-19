vim.api.nvim_set_keymap('n', '<leader>mds', ':Gvdiffsplit!<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'mdh', ':diffget //2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'mdl', ':diffget //3<CR>', {noremap = true, silent = true})
