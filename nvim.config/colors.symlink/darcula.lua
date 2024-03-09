vim.opt.background = "dark"
vim.g.colors_name = "darcula-solid-custom"

local lush = require("lush")
local hsl = lush.hsl
local hex = lush.hex
local darcula_solid = require("lush_theme.darcula-solid")
local spec = lush.extends({ darcula_solid }).with(function()
    -- Your modifications go here...
    -- Pallete copied from https://github.com/briones-gabriel/darcula-solid.nvim/blob/main/lua/lush_theme/darcula-solid.lu

    local bg = hsl(210, 7, 16)
    local red = hsl(1, 77, 59)
    local yellow = hsl(37, 100, 71)
    local green = hsl(83, 27, 53)

    return {
        Normal({ bg = bg, fg = darcula_solid.Normal.fg }),
        GitSignsAdd({ fg = green.da(20) }),
        GitSignsChange({ fg = yellow.da(20) }),
        GitSignsDelete({ fg = red }),
        DiffAdd({ bg = green.mix(bg, 70) }),
        DiffChange({ bg = yellow.mix(bg, 70) }),
        DiffText({ bg = green.mix(bg, 70) }),
        DiffDelete({ bg = red.mix(bg, 50) }),
    }
end)

lush(spec)
