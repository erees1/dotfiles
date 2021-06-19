-- Set leader
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

vim.cmd('luafile $HOME/git/dotfiles/vim.new/settings.lua') 
