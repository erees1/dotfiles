require("settings")
require("keybindings")
require("statusline")
require("fzf")
require("indent-guides").setup()
require("git-hunks").setup()
require("kitty-navigator").setup()
require("lsp")

-- Mini plugins
require('mini.comment').setup({
    mappings = {
        comment = '<D-/>',
        comment_line = '<D-/>',
        comment_visual = '<D-/>',
    }
})
require('mini.files').setup({})
vim.keymap.set('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Open file explorer' })

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
    fallback_action = function() end,  -- Do nothing when LSP has no results
    mappings = {
        force_twostep = '<C-n>',  -- Use Ctrl-L to trigger completion
        force_fallback = '',  -- Disable fallback trigger
        scroll_down = '<C-f>',
        scroll_up = '<C-b>',
    },
})




-- Reload config function
function ReloadConfig()
    -- Clear all loaded Lua modules from your config
    for name,_ in pairs(package.loaded) do
        if name:match('^keybindings') or name:match('^settings') or name:match('^plugins') or name:match('^statusline') or name:match('^minimal') or name:match('^vscode_keybindings') then
            package.loaded[name] = nil
        end
    end
    
    -- Source init.lua
    dofile(vim.env.MYVIMRC)
    vim.notify("Config reloaded!", vim.log.levels.INFO)
end

-- Reload keybinding
vim.keymap.set('n', '<leader>R', ':lua ReloadConfig()<CR>', { desc = 'Reload config' })
