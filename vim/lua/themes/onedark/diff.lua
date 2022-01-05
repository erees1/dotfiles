local M = {}
function M.init (C)
    local diff = {
      DiffAdd = { fg = C.none, bg = C.diff_add },
      DiffDelete = { fg = C.none, bg = C.diff_delete, style = "NONE" },
      DiffChange = { fg = C.none, bg = C.diff_change, style = "NONE" },
      DiffText = { fg = C.none, bg = C.diff_text, style = "NONE"  },
      DiffAdded = { fg = C.green },
      DiffRemoved = { fg = C.red },
      DiffFile = { fg = C.cyan },
      DiffIndexLine = { fg = C.gray },
    }

    return diff
end

return M
