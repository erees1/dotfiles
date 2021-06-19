-- Plugins using packer

-- Bootstrap install packer
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end
-- End of bootstrap

vim.cmd "autocmd BufWritePost plugins/init.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

-- Specify plugins here
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- CoC
  use {'neoclide/coc.nvim', config = function() vim.cmd('source $HOME/git/dotfiles/vim/vimscript/coc.vim') end} 

  -- Shortucts etc
  use {'preservim/nerdcommenter'}
  use 'christoomey/vim-tmux-navigator'

  -- Nvim tree / explorer stuff
  use {'kyazdani42/nvim-web-devicons'}
  use {'kyazdani42/nvim-tree.lua', 
        config = function() 
          require('plugins/nv-tree')
        end}

  -- Colors schemes
  use 'tjdevries/colorbuddy.nvim'
  use 'erees1/onebuddy'

  -- Treesitter for better highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    opt = true,
    run = ":TSUpdate",
    ft = {'python'},
    config = function() 
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {"python", "bash"},
        highlight = {
          enable = true,
        },
      } 
    end
  }

  -- Git
  use {'lewis6991/gitsigns.nvim', config = function() require('plugins/gitsigns') end}
  use {'tpope/vim-fugitive', config = function() require('plugins/fugitive') end}

  -- File navigation
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {'nvim-telescope/telescope.nvim', config = function() require('plugins/telescope') end}


  -- Appearance
  use {'hoob3rt/lualine.nvim', config = function() require('plugins/lualine') end}
  use 'jeffkreeftmeijer/vim-numbertoggle'
end)

