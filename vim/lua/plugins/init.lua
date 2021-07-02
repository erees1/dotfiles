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

  -- Appearance
  use {'hoob3rt/lualine.nvim',opt=true, config = function() require('plugins/lualine') end}
  use 'jeffkreeftmeijer/vim-numbertoggle'
 
  -- CoC
  use {'neoclide/coc.nvim',
        opt=true,
        ft = {'python', 'sh'},
        config = function() vim.cmd('source $HOME/git/dotfiles/vim/vimscript/coc.vim') end} 

  -- Shortucts etc
  use {'preservim/nerdcommenter', config = function() require('plugins/nerdcommenter') end}
  use 'christoomey/vim-tmux-navigator'

  -- Nvim tree / explorer stuff
  use {'kyazdani42/nvim-web-devicons'}
  use {'kyazdani42/nvim-tree.lua', 
        opt=true,
        cmd="NvimTreeToggle",
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
  use {'lewis6991/gitsigns.nvim',
        requires={'nvim-lua/plenary.nvim'},
        config = function() require('plugins/gitsigns') end}
  use {'tpope/vim-fugitive', config = function() require('plugins/fugitive') end}

  -- File navigation with telescope
  use {'nvim-telescope/telescope.nvim',
        opt=true,
        cmd={'Telescope'},
        config = function() require('plugins/telescope') end, 
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
       }



  -- Copy to OSC52
  use {'ojroques/vim-oscyank'}
end)

