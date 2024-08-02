return {
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            local function on_attach(bufnr)
                local api = require("nvim-tree.api")

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                api.config.mappings.default_on_attach(bufnr)

                -- Mappings migrated from view.mappings.list
                --
                -- You will need to insert "your code goes here" for any mappings with a custom action_cb
                vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
            end

            require("nvim-tree").setup({
                on_attach = on_attach,
                update_cwd = true,
                hijack_cursor = false,
                filters = {
                    dotfiles = false,
                    custom = { "node_modules", "__pycache__"},
                },
                git = {
                    ignore = false,
                },
                update_focused_file = {
                    -- enables the feature
                    enable = true,
                    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
                    -- only relevant when `update_focused_file.enable` is true
                    update_cwd = false,
                    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
                    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
                    ignore_list = {},
                },
                actions = {
                    open_file = {
                        quit_on_open = true,
                        resize_window = true,
                    },
                },
                view = {
                    width = 35,
                },
                renderer = {
                    indent_markers = { enable = false },
                    icons = {
                        show = {
                            git = true,
                            folder = true,
                            file = true,
                            folder_arrow = false,
                        },
                        glyphs = {
                            default = "",
                            symlink = "",
                            git = { unstaged = "", staged = "✓", unmerged = "", renamed = "➜", untracked = "" },
                            folder = { default = "", open = "", empty = "", empty_open = "", symlink = "" },
                        },
                    },
                },
            })

            if require("utils").is_not_vscode() then
                vim.keymap.set(
                    "n",
                    "<leader>e",
                    function() vim.api.nvim_command("NvimTreeFindFileToggle") end,
                    { noremap = true, silent = true }
                )
            end
        end,
    },
}
