local M = {}

function M.init (C)
    local highlights = require "onedark.Nvimtree".init(C)
    highlights["NvimTreeCursorLine"] = { bg = C.context, style = nil }
    return highlights
end
return M