vim.api.nvim_set_keymap("n", "<leader>tf", ":FzfLua files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tb", ":FzfLua buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tg", ":FzfLua live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tt", ":FzfLua git_files<CR>", { noremap = true, silent = true })

require("fzf-lua").setup({
	fzf_layout = "reverse",
	fzf_opts = {
		["--border"] = "none",
	},
	winopts = {
		win_height = 0.80, -- window height
		win_border = true, -- window border? or borderchars?
	},
	files = {
		find_opts = [[-type f -not -path '*/\.git/*' -not -path '*/resources/*' -not -path '*/testsets/*']],
	},
})
