-- Bootstrap install packer
local execute = vim.api.nvim_command
local fn = vim.fn

if require("funcs").is_not_vscode() then
    vim.g.coq_settings = {
        auto_start = "shut-up",
    }
end

-- Packer bootstrap
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

local packer = require("packer").startup({
    function(use)
        -- Packer can manage itself
        use("wbthomason/packer.nvim")

        -- Completion
        use({
            "neovim/nvim-lspconfig",
            requires = {
                { "ms-jpq/coq_nvim" },
                { "ms-jpq/coq.artifacts", branch = "artifacts" },
                { "jose-elias-alvarez/null-ls.nvim" },
            },
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
        -- use({
        --     "thaerkh/vim-workspace",
        --     -- config = function()
        --     --     vim.g.workspace_session_directory = fn.stdpath("data") .. "sessions"
        --     --     vim.g.undo_dir=fn.stdpath("data") .. "undodir"
        --     -- end
        -- })

        -- Copy to OSC52
        use({
            "ojroques/vim-oscyank",
            cond = { require("funcs").is_not_vscode },
            config = function()
                vim.g.oscyank_term="default"
            end,
        })

        if packer_bootstrap then
            require("packer").sync()
        end
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
    -- custom_load_map("<leader>e", "nvim-tree.lua")
    custom_load_map("<leader>tf", "fzf-lua")
end

return packer
