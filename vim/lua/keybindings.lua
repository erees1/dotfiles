-- Key Mappings
-- Note this is not all key mappings, generally ones specific to a plugin are in the plug-config folder

-- <leader>s to save
vim.api.nvim_set_keymap('n', '<leader>s', ':update<CR>', {noremap=true, silent=true }) -- leader s to save

-- Always use g mode which moves through wrapped lines as if they were actual lines
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap=false, silent=true })
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap=false, silent=true })

-- Shift + HL to move to start and end of visual line
vim.api.nvim_set_keymap('n', 'H', 'g^', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'L', 'g$', {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', 'H', 'g^', {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', 'L', 'g$', {noremap=true, silent=true })

-- Shift + JK to move to top and bottom of the screen
vim.api.nvim_set_keymap('n', 'J', 'L', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'K', 'H', {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', 'J', 'L', {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', 'K', 'H', {noremap=true, silent=true })
-- Copy paste from system buffers to make copy paste behaviour more sane
vim.api.nvim_set_keymap('v', 'y', '"+y', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'y', '"+y', {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', 'x', '"+x', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'x', '"+x', {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', 'p', '"+p', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'p', '"+p', {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', 'd', '"+d', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'd', '"+d', {noremap=true, silent=true })

-- Quick fix navigation
vim.api.nvim_set_keymap('n', '<M-n>', ':cn<CR>', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<M-p>', ':cp<CR>', {noremap=true, silent=true })

-- <leader><space> to clear highlighing after search
vim.api.nvim_set_keymap('n', '<Leader><space>', ':noh<CR>', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua _tree_toggle()<CR>', { noremap=true, silent=true })

-- I always seem to delete stuff at the bottom of the file with d k so remove
vim.api.nvim_set_keymap('n', 'dk', '<Nop>', {noremap=true, silent=true })
