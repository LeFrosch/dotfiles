local colors = require('gruvbox').palette

require('gruvbox').setup {
  transparent_mode = true,
  overrides = {
    -- Terminal, Mason, etc.
    FloatBorder = {
      bg = colors.dark0,
      fg = colors.light0,
    },
    -- Telescope stuff
    TelescopeBorder = {
      link = 'TelescopeNormal',
    },
    TelescopePreviewTitle = {
      link = 'TelescopeNormal',
    },
    TelescopePreviewDirectory = {
      fg = colors.bright_blue,
    },
    -- Hover documentation 
    NormalFloat = {
      bg = colors.dark1,
      fg = colors.light0,
    },
    -- Completion popup
    NormalPopup = {
      bg = colors.dark1,
      fg = colors.light0,
    },
    -- Go
    ['@constructor.go'] = {
      link = '@function.call.go'
    }
  }
}

vim.cmd.colorscheme('gruvbox')
