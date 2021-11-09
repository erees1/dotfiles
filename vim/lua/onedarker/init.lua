vim.api.nvim_command "hi clear"
if vim.fn.exists "syntax_on" then
  vim.api.nvim_command "syntax reset"
end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "onedarker"

local util = require "onedark.util"
Config = require "onedark.config"
C = require "onedarker.palette"
local highlights = require "onedark.highlights"
local Treesitter = require "onedark.Treesitter"
local markdown = require "onedark.markdown"
local Whichkey = require "onedark.Whichkey"
local Notify = require "onedark.Notify"
local Git = require "onedark.Git"
local LSP = require "onedark.LSP"
local diff = require "onedark.diff"
local tree = require "onedarker.Nvimtree"

local skeletons = {
  highlights,
  Treesitter,
  markdown,
  Whichkey,
  Notify,
  Git,
  LSP,
  diff,
  tree
}

for _, skeleton in ipairs(skeletons) do
  util.initialise(skeleton)
end
