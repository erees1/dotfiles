local M = {}
function M.init (C)
    local DV = {
        DiffViewNormal = { fg = C.gray, bg = C.alt_bg },
        FolderSign = { fg = C.fg, style = 'bold' },
        DiffviewFilePanelTitle = { fg = C.fg, style = 'bold' },
        DiffviewStatusAdded = { fg = C.sign_add },
        DiffviewStatusModified = { fg = C.sign_change },
        DiffviewStatusRenamed = { fg = C.sign_change },
        DiffviewStatusDeleted = { fg = C.sign_delete },
        DiffviewFilePanelInsertion = { fg = C.sign_add },
        DiffviewFilePanelDeletion = { fg = C.sign_delete },
        DiffviewFolderSign = { fg = C.blue },
        DiffviewVertSplit = {fg = C.alt_bg, bg = C.alt_bg },
        DiffviewEndOfBuffer = {fg = C.alt_bg },
    }
    return DV
end
return M
