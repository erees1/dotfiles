return {
    {
        "santos-gabriel-dario/darcula-solid.nvim",
        config = function() vim.cmd("colorscheme darcula") end,
        dependencies = { "rktjmp/lush.nvim" },
    },
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.cmd([[imap <silent><script><expr> <C-space> copilot#Accept("\<CR>")]])
        end,
        cond = { require("utils").is_not_vscode },
    },
    -- Shortucts etc
    { "tpope/vim-commentary" },
    {
        "christoomey/vim-tmux-navigator",
        cond = { require("utils").is_not_vscode },
    },
    {
        "ThePrimeagen/harpoon",
        config = function()
            vim.keymap.set("n", "<c-e>", require("harpoon.ui").toggle_quick_menu)
            vim.keymap.set("n", "<leader>a", function()
                require("harpoon.mark").add_file()
                print("added file to harpoon list")
            end)
            vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end)
            vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end)
            vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end)
            vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end)
        end,
    },
    -- Misc
    {
        "norcalli/nvim-colorizer.lua",
        opt = true,
        config = function() require("colorizer").setup() end,
    },

    {
        "907th/vim-auto-save",
        cond = { require("utils").is_not_vscode },
        config = function()
            vim.api.nvim_set_var("auto_save", 1)
            vim.api.nvim_set_var("auto_save_events", { "InsertLeave" })
        end,
    },
    {
        "mbbill/undotree",
        config = function()
            -- set <leader>u to toggle undo tree
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    -- Needed to copy from remote
    {
        "ojroques/vim-oscyank",
        cond = { require("utils").is_not_vscode },
        config = function() vim.g.oscyank_term = "default" end,
    },
    {
        "mg979/vim-visual-multi",
        config = function()
            vim.keymap.set("n", "<m-j>", "<Plug>(VM-Add-Cursor-Down)")
            vim.keymap.set("n", "<m-k>", "<Plug>(VM-Add-Cursor-Up)")
            vim.cmd(":VMTheme iceblue")
        end,
    },
}
