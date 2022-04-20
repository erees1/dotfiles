-- Bootstrap install packer
local execute = vim.api.nvim_command
local fn = vim.fn

-- Packer bootstrap
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    execute("packadd packer.nvim")
end

local packer = require("packer").startup({
    function()
        -- Packer can manage itself
        use("wbthomason/packer.nvim")

        -- Completion
        use({
            "neovim/nvim-lspconfig",
            requires = { "ms-jpq/coq_nvim", opt = true, "jose-elias-alvarez/null-ls.nvim", opt = true },
            config = function()
                require("plugins/lspconfig")
            end,
            cond = { require("funcs").is_not_vscode },
        })

        -- Shortucts etc
        use({ "tpope/vim-commentary" })
        use({
            "christoomey/vim-tmux-navigator",
            cond = { require("funcs").is_not_vscode },
        })

        -- Nvim tree / explorer stuff
        use({ "kyazdani42/nvim-web-devicons" })
        use({
            "kyazdani42/nvim-tree.lua",
            opt = true,
            config = function()
                require("plugins/nv-tree")
            end,
        })
        use({
            "romgrk/barbar.nvim",
            cond = { require("funcs").is_not_vscode },
            config = function()
                require("plugins/barbar")
            end,
        })

        -- Treesitter for better highlighting
        use({
            "nvim-treesitter/nvim-treesitter",
            opt = true,
            run = ":TSUpdate",
            cond = { require("funcs").is_not_vscode },
            ft = { "python" },
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = { "python" },
                    highlight = {
                        enable = true,
                    },
                })
            end,
        })

        -- Git
        use({
            "lewis6991/gitsigns.nvim",
            cond = { require("funcs").is_not_vscode },
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("plugins/gitsigns")
            end,
        })
        use({
            "tpope/vim-fugitive",
            cond = { require("funcs").is_not_vscode },
            config = function()
                require("plugins/fugitive")
            end,
            keys = { "gs", "<leader>ds" },
            cmd = { "Git", "G" },
        })
        use({
            "sindrets/diffview.nvim",
            keys = { "<leader>do", "<leader>df", "<leader>dh" },
            config = function()
                require("plugins.diffview")
            end,
        })

        -- fzf file navigation
        use({
            "ibhagwan/fzf-lua",
            keys = { "<leader>tb", "<leader>tg", "<leader>tt" },
            requires = {
                { "vijaymarupudi/nvim-fzf", opt = true },
                "kyazdani42/nvim-web-devicons",
            }, -- optional for icons
            cond = { require("funcs").is_not_vscode },
            config = function()
                require("plugins/fzf-lua")
            end,
        })

        -- Misc
        use({
            "norcalli/nvim-colorizer.lua",
            opt = true,
            config = function()
                require("colorizer").setup()
            end,
        })
        use({
            "907th/vim-auto-save",
            cond = { require("funcs").is_not_vscode },
            config = function()
                vim.api.nvim_set_var("auto_save", 1)
                vim.api.nvim_set_var("auto_save_events", { "InsertLeave" })
            end,
        })
        use({
            "https://github.com/iamcco/markdown-preview.nvim",
            opt = true,
            cmd = "MarkdownPreview",
        })

        -- Copy to OSC52
        use({
            "ojroques/vim-oscyank",
            cond = { require("funcs").is_not_vscode },
        })
    end,
    config = {
        display = {
            open_fn = require("packer.util").float,
        },
    },
})

if require("funcs").is_not_vscode then
    function custom_load_map(binding, plugin)
        local r = { noremap = true, silent = true }
        cmd = string.format(
            '<Cmd> lua require("packer.load")({\'%1s\'}, { keys = "%2s", prefix = "" }, _G.packer_plugins)<CR>',
            plugin,
            binding
        )
        remap("n", binding, cmd, r)
    end
    -- Becuase these bindings are also used in vscode we have to load ourselves rather than use
    -- keys option provided by packer as that overides the vscode specific shortcut
    custom_load_map("<leader>e", "nvim-tree.lua")
    custom_load_map("<leader>tf", "fzf-lua")
end

return packer
