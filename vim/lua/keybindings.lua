-- Key Mappings
-- Note this is not all key mappings, generally ones specific to a plugin 
-- in the plug-config folder

vim.api.nvim_set_keymap('n', '<leader>s', ':update<CR>', {noremap=true, silent=true }) -- leader s to save

-- Always use g mode which moves through wrapped lines as if they were actual lines
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'gj', 'j', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'gk', 'k', {noremap=true, silent=true })

-- jk in to escape insert mode
vim.api.nvim_set_keymap('i', 'jk', '<esc>', {noremap=true, silent=true })

-- Move lines up and down with the alt key a-la vscode
vim.api.nvim_set_keymap('n', '<A-j>' , ':m .+1<CR>==', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<A-k>' , ':m .-2<CR>==', {noremap=true, silent=true })
vim.api.nvim_set_keymap('i', '<A-j>' , ':m .+1<CR>==gi', {noremap=true, silent=true })
vim.api.nvim_set_keymap('i', '<A-k>' , ':m .-2<CR>==gi', {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', '<A-j>' , ":m '>+1<CR>gv=gv", {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', '<A-k>' , ":m '<-2<CR>gv=gv", {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<A-Down>', ':m .+1<CR>==', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<A-Up>' , ':m .-2<CR>==', {noremap=true, silent=true })
vim.api.nvim_set_keymap('i', '<A-Down>', ':m .+1<CR>==gi', {noremap=true, silent=true })
vim.api.nvim_set_keymap('i', '<A-Up>' , ':m .-2<CR>==gi', {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', '<A-Down>', ":m '>+1<CR>gv=gv", {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', '<A-Up>' , ":m '<-2<CR>gv=gv", {noremap=true, silent=true })

-- Don't cut - delete when using d or c, x will still cut
vim.api.nvim_set_keymap('n', 'd', '"_d', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'c', '"_c', {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', 'd', '"_d', {noremap=true, silent=true })
vim.api.nvim_set_keymap('v', 'c', '"_c', {noremap=true, silent=true })

-- Quick fix navigation
vim.api.nvim_set_keymap('n', '<M-n>', ':cn<CR>', {noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<M-p>', ':cp<CR>', {noremap=true, silent=true })

-- <leader><space> to clear highlighing after search
vim.api.nvim_set_keymap('n', '<Leader><space>', ':noh<CR>', {noremap=true, silent=true })


-- Keybindgs for plugins, optional plugin need to have their keybinds specified here, or can specify them
-- in keys= of packer

--Telescope
vim.api.nvim_set_keymap('n', '<c-p>', "<cmd> Telescope find_files<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>tf', "<cmd> Telescope find_files<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>tg', "<cmd> Telescope live_grep<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>tb', "<cmd> Telescope buffers<CR>", { noremap=true, silent=true })

