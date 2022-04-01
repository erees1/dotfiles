vim.api.nvim_set_var('nvim_tree_indent_markers',1)
vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {unstaged = "", staged = "✓", unmerged = "", renamed = "➜", untracked = ""},
    folder = {default = "", open = "", empty = "", empty_open = "", symlink = ""}
}

require'nvim-tree'.setup {
  update_cwd = true, 
  hijack_cursor = false,
  filters = {
    dotfiles = true,
    custom = {}
  },
  filters = {
    dotfiles = true,
    custom = {'node_modules'}
  },
  update_focused_file = {
    -- enables the feature
    enable = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = true,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  actions={
    open_file={
      resize_window = true,
    }
  },
  view = {
    -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = require('settings').tree_width,
  }
}


function _tree_toggle()
    if require'nvim-tree.view'.is_visible() then
        require'bufferline.state'.set_offset(0)
    else
        require'bufferline.state'.set_offset(require('settings').tree_width + 1, 'FileTree')
    end
    require'nvim-tree'.toggle()
end
