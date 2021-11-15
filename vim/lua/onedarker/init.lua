vim.api.nvim_command "hi clear"
if vim.fn.exists "syntax_on" then
  vim.api.nvim_command "syntax reset"
end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "onedarker"

--Need to set loaded to nil for onedark packages we are overiding
package.loaded["onedarker.palette"] = nil

local util = require "onedark.util"
Config = require "onedark.config"
local C = require "onedarker.palette"
local highlights = require "onedark.highlights".init(C)
local Treesitter = require "onedark.Treesitter".init(C)
local markdown = require "onedark.markdown".init(C)
local Whichkey = require "onedark.Whichkey".init(C)
local Notify = require "onedark.Notify".init(C)
local Git = require "onedark.Git".init(C)
local LSP = require "onedark.LSP".init(C)
local diff = require "onedark.diff".init(C)
local tree = require "onedarker.Nvimtree".init(C)
local diffview = require "onedark.diffview".init(C)

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
