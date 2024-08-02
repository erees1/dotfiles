-- add the keybindings above but for local buffer only
vim.keymap.set("n", "<CR>", ":.cc | cclose<CR>", { noremap = true, silent = true, buffer = true })
vim.keymap.set("n", "j", ":cn | wincmd p<CR>", { noremap = true, silent = true, buffer = true })
vim.keymap.set("n", "k", ":cp | wincmd p<CR>", { noremap = true, silent = true, buffer = true })

