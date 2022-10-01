vim.api.nvim_set_keymap("n", "<A-,>", ":BufferPrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-.>", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":BufferClose<CR>", { noremap = true, silent = true })

if package.loaded["nvim-tree"] then
    local api = require('nvim-tree.api')
    local bufferline_api = require('bufferline.api')

    local function get_tree_size()
      return require'nvim-tree.view'.View.width
    end

    api.events.subscribe('TreeOpen', function()
      bufferline_api.set_offset(get_tree_size() + 1)
    end)

    api.events.subscribe('Resize', function()
      bufferline_api.set_offset(get_tree_size() + 1)
    end)

    api.events.subscribe('TreeClose', function()
      bufferline_api.set_offset(0)
    end)
end
