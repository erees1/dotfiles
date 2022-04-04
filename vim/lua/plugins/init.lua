-- Bootstrap install packer
local execute = vim.api.nvim_command
local fn = vim.fn

-- Packer bootstrap
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup({function()

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Completion
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    cond = { require('funcs').is_not_vscode },
    opt=true,
    keys = {'<leader>f', 'gd', 'gr', 'gh', 'gi'},
    config = function() vim.cmd('source $HOME/git/dotfiles/vim/vimscript/coc.vim') end
  } 
  -- Shortucts etc
  use {
    'preservim/nerdcommenter',
    keys={"<leader>cc", "<leader>cip"},
    setup = function() vim.api.nvim_set_var('NERDCreateDefaultMappings', 0) end,
    config = function() require('plugins/nerdcommenter') end
  }
  use {
    'christoomey/vim-tmux-navigator',
    cond = { require('funcs').is_not_vscode },
  }

  -- Nvim tree / explorer stuff
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons'}, -- optional for icons
    cond = { require('funcs').is_not_vscode },
    keys = {'<leader>e'},
    config = function() 
      require('plugins/nv-tree')
    end
  }
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    cond = { require('funcs').is_not_vscode },
    config = function()
      require('plugins/barbar')
    end
  }

  -- Treesitter for better highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    opt=true,
    run = ":TSUpdate",
    cond = { require('funcs').is_not_vscode },
    ft = {'python'},
    config = function() 
      require('nvim-treesitter.configs').setup {
        ensure_installed = {"python"},
        highlight = {
          enable = true,
        },
      } 
    end
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    cond = { require('funcs').is_not_vscode },
    requires={'nvim-lua/plenary.nvim'},
    config = function() require('plugins/gitsigns') end
  }
  use {
    'tpope/vim-fugitive', 
    cond = { require('funcs').is_not_vscode },
    config = function() require('plugins/fugitive') end,
    keys = {'gs', '<leader>ds'},
    cmd = {'Git', 'G'}
  }
  use {
    'sindrets/diffview.nvim',
    keys = {'<leader>do', '<leader>df', '<leader>dh'},
    config = function() require('plugins.diffview') end
  }

  -- fzf file navigation
  use { 'ibhagwan/fzf-lua',
  keys = {'<leader>tf', '<leader>tb', '<leader>tg', '<leader>tt'},
  requires = {
      {'vijaymarupudi/nvim-fzf', opt=true},
    'kyazdani42/nvim-web-devicons' }, -- optional for icons
    cond = { require('funcs').is_not_vscode },
    config = function() require('plugins/fzf-lua') end,
  }

  -- Misc
  use {
    'norcalli/nvim-colorizer.lua',
    opt=true,
    config = function() require('colorizer').setup() end
  }
  use {
    '907th/vim-auto-save',
    cond = { require('funcs').is_not_vscode },
    config = function() vim.api.nvim_set_var('auto_save', 1) vim.api.nvim_set_var('auto_save_events', {'InsertLeave'}) end
  }
  use {
    'https://github.com/iamcco/markdown-preview.nvim',
    opt=true,
    cmd='MarkdownPreview',
  }
  -- Copy to OSC52
  use {
    'ojroques/vim-oscyank',
    cond = { require('funcs').is_not_vscode },
  }
end, 
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})
