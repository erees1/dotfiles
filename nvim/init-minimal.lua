print("Using minimal configuration")

-- No plugin manager configuration
require("settings")
require("keybindings")
require("statusline")
require("fzf")
require("manual-lsp").setup() -- Just ensures lsp_config plugin is downloaded
require("git-hunks").setup()
require("pyright").setup()
require("kitty-navigator").setup()



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
