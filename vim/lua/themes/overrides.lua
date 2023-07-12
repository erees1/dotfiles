local M = {}

local util = require("themes.util")
local C = require("themes.onedark.palette")


M.highlights = {
    StatusLine = { fg = C.fg, bg = C.fg_gutter, style = "bold" },
    StatusLineCentre = { fg = C.fg, bg = C.fg_gutter, style = "bold" },
    StatusLineFiletype = { fg = C.fg_gutter, bg = C.fg, style = "bold" },
    StatusLineNC = { fg = C.fg, bg = C.bg, style = "NONE" },
    StatusLineGit = { fg = C.fg, bg = C.context, style = "bold" },
    StatusLineMode = { fg = C.bg, bg = C.orange, style = "bold" },
    StatusLineModeAlt = { fg = C.bg, bg = C.blue, style = "bold" },
    StatusLineTerm = { fg = C.fg, bg = C.context, style = "bold" },
    StatusLineTermNC = { fg = C.context, bg = C.bg, style = "NONE" },
}

util.initialise(M.highlights)

return M
