local fn = vim.fn
local api = vim.api

local M = {}

-- possible values are 'arrow' | 'rounded' | 'blank'
vim.cmd("set laststatus=3")

-- highlight groups, just picked random ones from highlights that looked okay
M.colors = {
    active = "%#StatusLine#",
    inactive = "%#StatusLineNC#",
    mode = "%#IncSearch#",
    git = "%#StatusLine#",
    filetype = "%#Pmenusel#",
    line_col = "%#StatusLine#",
    lsp = "%#StatusLine#",
    filename = "%#StatusLine#",
}

M.trunc_width = setmetatable({
    git_status = 90,
    filename = 140,
}, {
    __index = function()
        return 80
    end,
})

M.is_truncated = function(_, width)
    local current_width = api.nvim_win_get_width(0)
    return current_width < width
end

M.modes = setmetatable({
    ["n"] = "N",
    ["no"] = "N·P",
    ["v"] = "V",
    ["V"] = "V·L",
    [""] = "V·B", -- this is not ^V, but it's , they're different
    ["s"] = "S",
    ["S"] = "S·L",
    ["i"] = "I",
    ["ic"] = "I",
    ["R"] = "R",
    ["Rv"] = "V·R",
    ["c"] = "C",
    ["cv"] = "V·E",
    ["ce"] = "E",
    ["r"] = "P",
    ["rm"] = "M",
    ["r?"] = "C",
    ["!"] = "S",
    ["t"] = "T",
}, {
    __index = function()
        return "U" -- handle edge cases
    end,
})

M.get_current_mode = function(self)
    local current_mode = api.nvim_get_mode().mode
    local mode_indicator = self.modes[current_mode]
    local color = M.colors.mode
    return string.format("%s %s ", color, mode_indicator)
end

M.get_git_status = function(self)
    -- use fallback because it doesn't set this variable on the initial `BufEnter`
    local signs = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }
    local is_head_empty = signs.head ~= ""

    if self:is_truncated(self.trunc_width.git_status) then
        return is_head_empty and string.format("  %s ", signs.head or "") or ""
    end

    return is_head_empty
            and string.format("  %s | +%s ~%s -%s ", signs.head, signs.added, signs.changed, signs.removed)
        or ""
end

M.get_filepath = function(self)
    local filepath = fn.fnamemodify(fn.expand("%"), ":.:h")
    if filepath == "" or filepath == "." or self:is_truncated(self.trunc_width.filename) then
        return " "
    end

    return string.format(" %%<%s/", filepath)
end

M.get_filename = function()
    local filename = fn.expand("%:t")
    if filename == "" then
        return ""
    end
    return filename
end

M.get_filetype = function()
    local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
    local icon = require("nvim-web-devicons").get_icon(file_name, file_ext, { default = true })
    local filetype = vim.bo.filetype

    if filetype == "" then
        return " No FT "
    end
    return string.format(" %s %s ", icon, filetype):lower()
end

M.lsp_progress = function()
    local lsp = vim.lsp.util.get_progress_messages()[1]
    if lsp then
        local name = lsp.name or ""
        local msg = lsp.message or ""
        local percentage = lsp.percentage or 0
        local title = lsp.title or ""
        return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
    end

    return ""
end

M.set_active = function(self)
    local colors = self.colors

    local mode = self:get_current_mode()
    local git = colors.git .. self:get_git_status()

    local filename = string.format(
        "%s%s%s%s %s",
        colors.filename,
        self:get_filepath(),
        colors.filename,
        self:get_filename(),
        colors.active
    )

    local filetype = colors.filetype .. self:get_filetype()
    local lsp = colors.lsp .. self:lsp_progress()

    return table.concat({
        mode,
        git,
        filename,
        "%=",
        lsp,
        filetype,
    })
end

function Statusline()
    return M.set_active(M)
end

vim.cmd([[set statusline=%!v:lua.Statusline()]])
