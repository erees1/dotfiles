vim.api.nvim_set_var('NERDSpaceDelims', 1)
vim.api.nvim_set_var('NERDDefaultAlign', 'left')

vim.api.nvim_set_keymap('n', '<leader>c', ":call nerdcommenter#Comment('n', 'toggle')<cr>", {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', '<leader>c', ":call nerdcommenter#Comment('v', 'toggle')<cr>", {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>cip' "Vip:call nerdcommenter#Comment('v', 'toggle')<cr>", {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>cap' "Vap:call nerdcommenter#Comment('v', 'toggle')<cr>", {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>c}' "V}:call nerdcommenter#Comment('v', 'toggle')<cr>", {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>c{' "V{:call nerdcommenter#Comment('v', 'toggle')<cr>", {noremap=true, silent=true })
