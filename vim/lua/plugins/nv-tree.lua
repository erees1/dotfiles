vim.api.nvim_set_var('nvim_tree_ignore', {'.git', 'node_modules', '.cache' })
vim.api.nvim_set_var('nvim_tree_auto_open', 0)
vim.api.nvim_set_var('nvim_tree_quit_on_open',0)
vim.api.nvim_set_var('nvim_tree_indent_markers',1)
vim.api.nvim_set_var('nvim_tree_hide_dotfiles',1)
vim.api.nvim_set_var('nvim_tree_update_cwd', 1)
vim.api.nvim_set_var('nvim_tree_follow', 1)
vim.api.nvim_set_var('nvim_tree_hijack_cursor', 0)
vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {unstaged = "", staged = "✓", unmerged = "", renamed = "➜", untracked = ""},
    folder = {default = "", open = "", empty = "", empty_open = "", symlink = ""}
}

require'nvim-tree'.setup {
  update_focused_file = {
    -- enables the feature
    enable      = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = tree_width,
  }
}
