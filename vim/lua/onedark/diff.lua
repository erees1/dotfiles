local M = {}
function M.init (C)
    local diff = {
      DiffAdd = { fg = C.none, bg = C.diff_add },
      DiffDelete = { fg = C.none, bg = C.diff_delete },
      DiffChange = { fg = C.none, bg = C.diff_change },
      DiffText = { fg = C.none, bg = C.diff_text },
      DiffAdded = { fg = C.green },
      DiffRemoved = { fg = C.red },
      DiffFile = { fg = C.cyan },
      DiffIndexLine = { fg = C.gray },
    }

    return diff
end

return M
