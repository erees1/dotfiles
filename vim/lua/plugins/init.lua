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
    {
        "projekt0n/github-nvim-theme",
        config = function()
            require("github-theme").setup({
                options = {
                    hide_end_of_buffer = true,
                    transparent = true,
                },
            })
            vim.cmd("colorscheme github_dark_dimmed")
            require("themes.overrides")
        end,
    },

    -- LSP Completion
    {
        "neovim/nvim-lspconfig",
        dependencies = { "jose-elias-alvarez/null-ls.nvim" },
        cond = { require("utils").is_not_vscode },
        config = function()
            require("plugins/lsp_config")
        end,
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
            "quangnguyen30192/cmp-nvim-ultisnips",
            "hrsh7th/cmp-nvim-lua",
            "octaltree/cmp-look",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "f3fora/cmp-spell",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                completion = {
                    keyword_length = 0, -- Min word length before showing result
                    autocomplete = false, -- Dont auto popup
                },
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-l>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    -- { name = "vsnip" }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    { name = "ultisnips" }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
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
        config = function()
            require("plugins/nv-tree")
        end,
    },

    -- Git
    {
        "lewis6991/gitsigns.nvim",
        cond = { require("utils").is_not_vscode },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins/gitsigns")
        end,
    },

    {
        "tpope/vim-fugitive",
        cond = { require("utils").is_not_vscode },
        config = function()
            require("plugins/fugitive")
        end,
        keys = { "gs", "<leader>ds" },
        cmd = { "Git", "G" },
    },

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins/telescope")
        end,
    },

    -- Misc
    {
        "norcalli/nvim-colorizer.lua",
        opt = true,
        config = function()
            require("colorizer").setup()
        end,
    },

    {
        "907th/vim-auto-save",
        cond = { require("utils").is_not_vscode },
        config = function()
            vim.api.nvim_set_var("auto_save", 1)
            vim.api.nvim_set_var("auto_save_events", { "InsertLeave" })
        end,
    },

    -- Copy to OSC52
    {
        "ojroques/vim-oscyank",
        cond = { require("utils").is_not_vscode },
        config = function()
            vim.g.oscyank_term = "default"
        end,
    },
}

require("lazy").setup(plugin_list)
