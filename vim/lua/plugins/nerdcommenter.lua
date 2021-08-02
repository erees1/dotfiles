vim.api.nvim_set_var('NERDCreateDefaultMappings', 0)
vim.api.nvim_set_keymap('n', '<leader>ci', ":call nerdcommenter#Comment('n', 'toggle')<cr>", {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', '<leader>ci', ":call nerdcommenter#Comment('v', 'toggle')<cr>", {noremap=true, silent=true })
