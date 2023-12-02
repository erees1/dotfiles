local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


local plugin_list = {
    -- Colorschme Or with configuration

    -- { "morhetz/gruvbox", config = function() vim.cmd.colorscheme("gruvbox") end },

    {

        "https://github.com/ellisonleao/gruvbox.nvim",
        -- Default options:
        config = function()
            require("gruvbox").setup({
                transparent_mode = true,
                bold = false,
                overrides = {
                    ["Pmenu"] = { bg = "#23272E" },
                    ["@lsp.type.function"] = { fg = "#98BF83" },
                    ["function"] = { fg = "#98BF83" },
                    ["NormalFloat"] = { bg = "#23272E" },
                },
            })
            vim.cmd("colorscheme gruvbox")
        end,
    },
    -- LSP Completion
    {
        "williamboman/mason.nvim",
        cond = { require("utils").is_not_vscode },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        cond = { require("utils").is_not_vscode },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "jose-elias-alvarez/null-ls.nvim" },
        cond = { require("utils").is_not_vscode },
        config = function() require("plugins/lsp_config") end,
    },
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.cmd([[imap <silent><script><expr> <C-space> copilot#Accept("\<CR>")]])
        end,
        cond = { require("utils").is_not_vscode },
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                completion = {
                    keyword_length = 3, -- Min word length before showing result
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-l>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "nvim_lsp_signature_help" },
                }),
            })
        end,
        cond = { require("utils").is_not_vscode },
    },

    -- Shortucts etc
    { "tpope/vim-commentary" },

    {
        "christoomey/vim-tmux-navigator",
        cond = { require("utils").is_not_vscode },
    },

    -- Nvim tree / explorer stuff
    { "kyazdani42/nvim-web-devicons", lazy = true },

    {
        "kyazdani42/nvim-tree.lua",
        config = function() require("plugins/nv-tree") end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function() require("plugins/treesitter") end,
    },

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        cond = { require("utils").is_not_vscode },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("plugins/gitsigns") end,
    },

    {
        "tpope/vim-fugitive",
        cond = { require("utils").is_not_vscode },
        config = function() require("plugins/fugitive") end,
        keys = { "gs", "<leader>ds" },
        cmd = { "Git", "G" },
    },

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require("plugins/telescope") end,
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
    -- undo tree
    {
        "mbbill/undotree",
        config = function()
            -- set <leader>u to toggle undo tree
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    -- Copy to OSC52
    {
        "ojroques/vim-oscyank",
        cond = { require("utils").is_not_vscode },
        config = function() vim.g.oscyank_term = "default" end,
    },
}

require("lazy").setup(plugin_list)
