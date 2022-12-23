local M = {}


function M.VertGStatus()
    if package.loaded["nvim-tree"] then
        require("nvim-tree.view").close()
    end
	s = require("utils").git_window_width
	vim.cmd("vert Git")
	cmd = string.format("vert resize %s", s)
	vim.cmd(cmd)
	require("bufferline.api").set_offset(s + 1)
end

function M.GClose()
	vim.cmd("normal gq")
    require('utils').reset_bufferline()
end

function M.GDiffOpen()
	local cur_win = vim.api.nvim_get_current_win()
	vim.cmd("normal dv")
	vim.api.nvim_set_current_win(cur_win)
end

vim.cmd([[
augroup fugitive_au
  autocmd!
  autocmd FileType fugitive setlocal winfixwidth
  autocmd FileType fugitive setlocal nobuflisted
  autocmd FileType fugitive setlocal nonumber | setlocal norelativenumber
  autocmd FileType fugitive setlocal winhighlight=Normal:DiffViewNormal,WinSeparator:DiffviewVertSplit,EndOfBuffer:DiffviewEndOfBuffer,SignColumn:DiffViewNormal
  autocmd FileType fugitive nnoremap <buffer> gs <cmd>lua require('plugins.fugitive').GClose()<CR>
  autocmd FileType fugitive nnoremap <buffer> dd <cmd>lua require('plugins.fugitive').GDiffOpen()<CR>
  autocmd FileType gitcommit wincmd J
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
]])

vim.keymap.set("n", "gs", ":lua require('plugins.fugitive').VertGStatus()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ds", ":Gvdiffsplit!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mh", ":diffget //2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ml", ":diffget //3<CR>", { noremap = true, silent = true })

return M
