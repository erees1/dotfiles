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
  local local_use = function(first, second, opts)
    opts = opts or {}

    local plug_path, home
    if second == nil then
      plug_path = first
      home = "erees1"
    else
      plug_path = second
      home = first
    end

    if vim.fn.isdirectory(vim.fn.expand("~/git/" .. plug_path)) == 1 then
      opts[1] = "~/git/" .. plug_path
    else
      opts[1] = string.format("%s/%s", home, plug_path)
    end

    use(opts)
  end

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
      '907th/vim-auto-save',
      cond = { require('funcs').is_not_vscode },
      config = function() vim.api.nvim_set_var('auto_save', 1) vim.api.nvim_set_var('auto_save_events', {'InsertLeave'}) end
  }

  -- CoC
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    cond = { require('funcs').is_not_vscode },
    opt=true,
    ft = {'python', 'sh'},
    config = function() vim.cmd('source $HOME/git/dotfiles/vim/vimscript/coc.vim') end
  } 

  -- Shortucts etc
  use {
    'preservim/nerdcommenter',
    cond = { require('funcs').is_not_vscode },
    config = function() require('plugins/nerdcommenter') end
  }
  use {
    'christoomey/vim-tmux-navigator',
    cond = is_not_vscode,
  }

  -- Nvim tree / explorer stuff
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons' }, -- optional for icons
    cond = { require('funcs').is_not_vscode },
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
      require('plugins/tree')
    end
  }

  -- Treesitter for better highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    cond = { require('funcs').is_not_vscode },
    ft = {'python'},
    config = function() 
      require'nvim-treesitter.configs'.setup {
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
    config = function() require('plugins/fugitive') end
  }

  use { 'ibhagwan/fzf-lua',
    requires = {
      'vijaymarupudi/nvim-fzf',
      'kyazdani42/nvim-web-devicons' }, -- optional for icons
      cond = { require('funcs').is_not_vscode },
      config = function() require('plugins/fzf-lua') end,
  }
  -- Misc
  use {
    'norcalli/nvim-colorizer.lua',
    opt=true,
    cond = { require('funcs').is_not_vscode },
    config = function() require'colorizer'.setup() end
  }

  -- Copy to OSC52
  use {
    'ojroques/vim-oscyank',
    cond = { require('funcs').is_not_vscode },
  }
end)

