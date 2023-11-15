local lazy = require('lazy')

local plugins = {
  -- Automatically detects tab settings
  { 'tpope/vim-sleuth' },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('config.nvim-treesitter')
    end
  },

  -- Theme
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('config.tokyonight')
    end
  },

  -- Which Key
  {
    'folke/which-key.nvim',
    config = function()
      require('config.which-key')
    end
  },

  -- File tree
  {
    'kyazdani42/nvim-tree.lua',
    lazy = false,
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('config.nvim-tree')
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      'folke/neodev.nvim',
    },
    config = function()
      require('config.lsp')
    end
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('config.nvim-cmp')
    end
  },
}

local opts = {}

lazy.setup(plugins, opts)
