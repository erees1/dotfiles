require('telescope').setup{ defaults = { file_ignore_patterns = {"resources", "htmlcov"} } }
vim.api.nvim_set_keymap('n', '<c-p>', '<cmd>Telescope find_files<CR>', { noremap=true, silent=true })
