local lazy = require('lazy')


local plugins = {
  -- Automatically detects tab settings
  { 'tpope/vim-sleuth' },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
    },
    config = function()
      require('config.nvim-treesitter')
    end
  },

  -- Theme
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('config.gruvbox')
    end
  },

  -- Which Key
  {
    'folke/which-key.nvim',
    config = function()
      require('config.which-key')
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

  -- DAP
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('config.nvim-dap')
    end
  },

  -- Linter
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('config.nvim-lint')
    end
  },

  -- Formatter
  {
    'stevearc/conform.nvim',
    config = function ()
      require('config.conform')
    end
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet engine
      'L3MON4D3/LuaSnip',

      -- LSP completions
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('config.nvim-cmp')
    end
  },

  -- Autocomplete braces
  {
    'windwp/nvim-autopairs',
    config = function()
      require('config.nvim-autopairs')
    end
  },

  -- Diagonsitcs
  {
    "folke/trouble.nvim",
    config = function()
      require('config.trouble')
    end
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    config = function()
      require('config.nvim-telescope')
    end
  },

  -- File browser
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    }
  },

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('config.toggelterm')
    end
  },

  -- GitGutter
  {
    'airblade/vim-gitgutter',
    config = function()
    end
  },
}

local opts = {}

lazy.setup(plugins, opts)
