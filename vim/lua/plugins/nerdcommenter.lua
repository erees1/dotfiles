vim.api.nvim_set_var('NERDSpaceDelims', 1)
vim.api.nvim_set_var('NERDDefaultAlign', 'left')

vim.api.nvim_set_keymap('n', '<leader>cc', ":call nerdcommenter#Comment('n', 'toggle')<cr>", {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', '<leader>cc', ":call nerdcommenter#Comment('v', 'toggle')<cr>", {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>cip', "mzVip:call nerdcommenter#Comment('v', 'toggle')<cr>`z", {noremap=true, silent=true })

