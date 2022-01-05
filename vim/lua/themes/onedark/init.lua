vim.api.nvim_command "hi clear"
if vim.fn.exists "syntax_on" then
  vim.api.nvim_command "syntax reset"
end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "onedark"

package.loaded["themes.onedark.palette"] = nil

local util = require "themes.onedark.util"
Config = require "themes.onedark.config"
local C = require "themes.onedark.palette"
local highlights = require "themes.onedark.highlights".init(C)
local Treesitter = require "themes.onedark.Treesitter".init(C)
local markdown = require "themes.onedark.markdown".init(C)
local Whichkey = require "themes.onedark.Whichkey".init(C)
local Notify = require "themes.onedark.Notify".init(C)
local Git = require "themes.onedark.Git".init(C)
local LSP = require "themes.onedark.LSP".init(C)
local diff = require "themes.onedark.diff".init(C)
local tree = require "themes.onedark.Nvimtree".init(C)
local diffview = require "themes.onedark.diffview".init(C)

local skeletons = {
  highlights,
  Treesitter,
  markdown,
  Whichkey,
  Notify,
  Git,
  LSP,
  diff,
  tree,
  diffview,
}

for _, skeleton in ipairs(skeletons) do
  util.initialise(skeleton)
end
