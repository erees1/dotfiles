-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "bottom",
            },
        },
    },
    mappings = {
        i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
            ["<esc>"] = actions.close,
        },
    },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    -- exit on esc when in insert mode
    vim.keymap.set("i", "<ESC>", "<ESC>:q!<cr>", { noremap = true, silent = true, buffer=true })
  end,
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>ob", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>t", require("telescope.builtin").find_files,   { desc = "[T]elescope" })
vim.keymap.set("n", "<leader>of", require("telescope.builtin").find_files,  { desc = "Telescp[o]pe [F]iles" })
vim.keymap.set("n", "<leader>oh", require("telescope.builtin").help_tags,   { desc = "Telescp[o]pe [H]elp" })
vim.keymap.set("n", "<leader>ow", require("telescope.builtin").grep_string, { desc = "Telescp[o]pe current [W]ord" })
vim.keymap.set("n", "<leader>og", require("telescope.builtin").live_grep,   { desc = "Telescp[o]pe by [G]rep" })
vim.keymap.set("n", "<leader>od", require("telescope.builtin").diagnostics, { desc = "Telescp[o]pe [D]iagnostics" })
