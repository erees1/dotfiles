vim.api.nvim_set_var('nvim_tree_ignore', {'.git', 'node_modules', '.cache' })
vim.api.nvim_set_var('nvim_tree_auto_open', 1)
vim.api.nvim_set_var('nvim_tree_quit_on_open',1)
vim.api.nvim_set_var('nvim_tree_indent_markers',1)
vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {unstaged = "", staged = "✓", unmerged = "", renamed = "➜", untracked = ""},
    folder = {default = "", open = "", empty = "", empty_open = "", symlink = ""}
}