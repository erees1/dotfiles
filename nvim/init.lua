require("settings")
require("keybindings")
require("statusline")
require("winbar").setup()
require("fzf")
require("git-hunks").setup()
require("kitty-navigator").setup()
require("lsp")
require("claude").setup()

-- Mini plugins
require('mini.comment').setup({
    mappings = {
        comment = '<D-/>',
        comment_line = '<D-/>',
        comment_visual = '<D-/>',
    }
})
require('mini.files').setup({})
vim.keymap.set('n', '<leader>e', function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, { desc = 'Open file explorer focused on current file' })
vim.keymap.set('n', '<leader>E', function() MiniFiles.open() end, { desc = 'Open file explorer at root' })

require('mini.completion').setup({
    delay = { 
        completion = 10000000,  -- Effectively disable auto-completion
        info = 100, 
        signature = 50 
    },
    lsp_completion = {
        source_func = 'completefunc',  -- or 'omnifunc'
        auto_setup = true,
    },
    fallback_action = "<C-N>",
    mappings = {
        force_twostep = '<C-l>',  -- Use Ctrl-L to trigger completion
        force_fallback = '',  -- Disable fallback trigger
        scroll_down = '<C-f>',
        scroll_up = '<C-b>',
    },
})

require('mini.hues').setup({
    -- Base colors (required)
    background = '#26222d',
    foreground = '#d0d0d0',

    -- Number of hues for non-base colors (0-8)
    n_hues = 8,

    -- Saturation level
    saturation = 'mediumhigh',  -- 'low', 'lowmedium', 'medium', 'mediumhigh', 'high'


    -- Plugin integrations
    plugins = {
        default = false,  -- Enable all by default
    },
})
-- Override winbar and statusbar colors for better visibility
vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#3a3540', fg = '#e6e6e6' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#323238', fg = '#999999' })
vim.api.nvim_set_hl(0, 'WinBar', { bg = '#3a3540', fg = '#e6e6e6' })
vim.api.nvim_set_hl(0, 'WinBarNC', { bg = '#323238', fg = '#999999' })

local palette = require('mini.hues').get_palette()
vim.api.nvim_set_hl(0, 'Statement', { fg = '#e06c75', bold = false })        -- return, pass, break
vim.api.nvim_set_hl(0, 'Conditional', { fg = palette.orange, bold = false }) -- if, elif, else
vim.api.nvim_set_hl(0, 'Repeat', { fg = palette.orange })                    -- for, while loops
vim.api.nvim_set_hl(0, 'Exception', { fg = palette.orange, bold = false })   -- try, except, finally, raise
vim.api.nvim_set_hl(0, 'Include', { fg = palette.purple, bold = false })     -- import, from
vim.api.nvim_set_hl(0, 'Operator', { fg = palette.orange })                  -- and, or, not, in, is
vim.api.nvim_set_hl(0, 'Async', { fg = palette.purple, bold = false })       -- async/await
vim.api.nvim_set_hl(0, 'Function', { fg = palette.orange, bold = true })     -- function definitions
vim.api.nvim_set_hl(0, 'TypeDef', { fg = palette.orange, bold = false })     -- type definitions
vim.api.nvim_set_hl(0, 'Type', { fg = palette.orange, bold = false })        -- types
vim.api.nvim_set_hl(0, 'pythonBuiltin', { fg = palette.blue, bold = false }) -- builtin functions

-- After setting any colorschemes
require("indent-guides").setup()


-- Reload config function
function ReloadConfig()
    -- Clear all loaded Lua modules from your config
    for name,_ in pairs(package.loaded) do
        package.loaded[name] = nil
    end
    
    -- Source init.lua
    dofile(vim.env.MYVIMRC)
    vim.notify("Config reloaded!", vim.log.levels.INFO)
end

vim.keymap.set('n', '<leader>R', ':lua ReloadConfig()<CR>', { desc = 'Reload config', silent = true })
