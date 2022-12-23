vim.keymap.set("n", "<leader>t", ":FzfLua files<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>tb", ":FzfLua buffers<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>tg", ":FzfLua live_grep<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>tt", ":FzfLua git_files<CR>", { noremap = true, silent = true })

require("fzf-lua").setup({
	fzf_layout = "reverse",
    files = {
        git_icons = false,
        file_icons = false,
		find_opts = [[-type f -not -path '*/\.git/*' -not -path '*/resources/*' -not -path '*/testsets/*']],
    },
    fzf_opts = { ['--ansi'] = false},
    preview_opts = 'hidden',
	winopts = {
		win_height = 0.80, -- window height
        win_width = 0.70,
		win_border = true, -- window border? or borderchars?
	},
})
