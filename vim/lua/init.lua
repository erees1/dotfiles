-- Set leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

if require('funcs').is_not_vscode then
    require('statusline')
    require('settings')
end
-- Keybindings need to be compatible with vscode
require('plugins')
require('keybindings')

