 vim.api.nvim_command([[
let g:fzf_colors = {'bg+': ['bg','visual']}
]])


--FZF - overwrite telescope
vim.api.nvim_set_keymap('n', '<c-p>', ":FZF<CR>", { noremap=true, silent=true })
