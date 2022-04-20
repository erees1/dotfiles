local M = {}

function M.init(C)
	local highlights = {
		--NvimTreeStatusLine = { fg = C.fg, bg = C.alt_bg, style = nil },
		--NvimTreeStatusLineNC = { fg = C.alt_bg, bg = C.alt_bg, style = nil },
		NvimTreeEndOfBuffer = { fg = C.alt_bg },
		NvimTreeFolderIcon = { fg = C.blue },
		NvimTreeIndentMarker = { fg = C.gray },
		NvimTreeNormal = { fg = C.light_gray, bg = C.alt_bg },
		NvimTreeVertSplit = { fg = C.alt_bg, bg = C.alt_bg },
		NvimTreeWinSeparator = { fg = C.alt_bg, bg = C.alt_bg },
		NvimTreeFolderName = { fg = C.blue },
		NvimTreeFolderIcon = { fg = C.blue },
		NvimTreeRootFolder = { fg = C.fg, style = "bold" },
		NvimTreeOpenedFolderName = { fg = C.cyan, style = "italic" },
		NvimTreeImageFile = { fg = C.purple },
		NvimTreeSpecialFile = { fg = C.orange },
		NvimTreeGitStaged = { fg = C.sign_add },
		NvimTreeCursorLine = { bg = C.bg },
		NvimTreeGitNew = { fg = C.sign_add },
		NvimTreeGitDirty = { fg = C.sign_add },
		NvimTreeGitDeleted = { fg = C.sign_delete },
		NvimTreeGitMerge = { fg = C.sign_change },
		NvimTreeGitRenamed = { fg = C.sign_change },
		NvimTreeSymlink = { fg = C.purple },
		NvimTreeExecFile = { fg = C.red },
	}
	return highlights
end
return M
