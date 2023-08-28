local M = {}

function M.init(C)
	local Whichkey = {
		WhichKey = { fg = C.purple },
		WhichKeySeperator = { fg = C.green },
		WhichKeyGroup = { fg = C.cyan },
		WhichKeyDesc = { fg = C.blue },
		WhichKeyFloat = { bg = C.dark },
	}

	return Whichkey
end

return M
