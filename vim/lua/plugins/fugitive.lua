_VertGStatus = function()
	s = require("settings").git_window_width
	vim.cmd("vert Git")
	cmd = string.format("vert resize %s", s)
	vim.cmd(cmd)
	require("bufferline.state").set_offset(s + 1)
end

_GClose = function()
	vim.cmd("normal gq")
	require("bufferline.state").set_offset(0)
end
_GDiffOpen = function()
	local cur_win = vim.api.nvim_get_current_win()
	vim.cmd("normal dv")
	vim.api.nvim_set_current_win(cur_win)
end

vim.cmd([[
augroup fugitive_au
  autocmd!
  autocmd FileType fugitive setlocal winfixwidth
  autocmd FileType fugitive setlocal nonumber | setlocal norelativenumber
  autocmd FileType fugitive setlocal winhighlight=Normal:DiffViewNormal,WinSeparator:DiffviewVertSplit,EndOfBuffer:DiffviewEndOfBuffer,SignColumn:DiffViewNormal
  autocmd FileType fugitive nnoremap <buffer> gs <cmd>lua _GClose()<CR> 
  autocmd FileType fugitive nnoremap <buffer> dd <cmd>lua _GDiffOpen()<CR>
  autocmd FileType gitcommit wincmd J 
  augroup END
]])

vim.api.nvim_set_keymap("n", "gs", "<cmd>lua _VertGStatus()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ds", ":Gvdiffsplit!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "mo", ":call ResetBarBarOffset()<CR> <C-W><C-O>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "mh", ":diffget //2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "ml", ":diffget //3<CR>", { noremap = true, silent = true })
