local colors = require('gruvbox').palette

require('gruvbox').setup {
  transparent_mode = true,
  overrides = {
    -- Dialog
    NormalDialog = {
      fg = colors.light0,
    },
    FloatBorder = {
      fg = colors.light2,
    },

    -- Mason
    MasonNormal = {
      link = 'NormalDialog',
    },

    -- Telescope
    TelescopeNormal = {
      link = 'NormalDialog',
    },
    TelescopeBorder = {
      link = 'FloatBorder',
    },
    TelescopeResultsBorder = {
      link = 'FloatBorder',
    },
    TelescopePromptBorder = {
      link = 'FloatBorder',
    },
    TelescopePreviewBorder = {
      link = 'FloatBorder',
    },
    TelescopePreviewDirectory = {
      fg = colors.bright_blue,
    },

    -- Popups
    NormalPopup = {
      bg = colors.dark1,
      fg = colors.light0,
    },

    -- Hover Documentation
    NormalFloat = {
      link = 'NormalPopup',
    },

    -- Go
    ['@constructor.go'] = {
      link = '@function.call.go'
    }
  }
}

vim.cmd.colorscheme('gruvbox')
