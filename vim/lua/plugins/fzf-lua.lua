vim.api.nvim_set_keymap('n', '<c-p>', ":FzfLua files<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>tg', ":FzfLua files<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>tb', ":FzfLua buffer<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>tg', ":FzfLua live_grep<CR>", { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>tt', ":FzfLua git_files<CR>", { noremap=true, silent=true })
require'fzf-lua'.setup {
    fzf_layout          = 'reverse',
    winopts = {
    win_height       = 0.80,            -- window height
    win_border       = true,           -- window border? or borderchars?
  },
    files = {
        cmd = "find . -type d -name '.git' -prune -o -type f -print"
    },
}
