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
      config = function() vim.api.nvim_set_var('auto_save', 1) vim.api.nvim_set_var('auto_save_events', {'InsertLeave'}) end
  }
  -- Appearance
  use {
    'hoob3rt/lualine.nvim',
    opt=true,
    config = function() require('plugins/lualine') end
  }
  use {
    'jeffkreeftmeijer/vim-numbertoggle',
    opt=true
  }

  -- CoC
  use {
    'neoclide/coc.nvim',
    opt=true,
    ft = {'python', 'sh'},
    config = function() vim.cmd('source $HOME/git/dotfiles/vim/vimscript/coc.vim') end
  } 

  -- Shortucts etc
  use {
    'preservim/nerdcommenter', config = function() require('plugins/nerdcommenter') end
  }
  use {
    'christoomey/vim-tmux-navigator'
  }

  -- Nvim tree / explorer stuff
  use {
    'kyazdani42/nvim-web-devicons'
  }
  use {
    'kyazdani42/nvim-tree.lua', 
    config = function() 
      require('plugins/nv-tree')
    end
  }

  -- Colors schemes
  local_use 'color-schemes.vim'
   

  -- Treesitter for better highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
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
    requires={'nvim-lua/plenary.nvim'},
    config = function() require('plugins/gitsigns') end
  }
  use {
    'tpope/vim-fugitive', config = function() require('plugins/fugitive') end
  }

  use { 'ibhagwan/fzf-lua',
    requires = {
      'vijaymarupudi/nvim-fzf',
      'kyazdani42/nvim-web-devicons' }, -- optional for icons
      config = function() require('plugins/fzf-lua') end,
  }
  -- Misc
  use {
    'norcalli/nvim-colorizer.lua',
    opt=true,
    config = function() require'colorizer'.setup() end
  }

  -- Copy to OSC52
  use {'ojroques/vim-oscyank'}
end)

