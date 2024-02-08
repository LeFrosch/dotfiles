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
      bg = colors.dark0,
      fg = colors.light0,
    },
    TelescopePreviewDirectory = {
      fg = colors.bright_blue,
    },
    -- Hover documentation 
    NormalFloat = {
      bg = colors.dark1,
      fg = colors.light0,
    },
    -- Fix issue in lua documentation
    luaParenError = {},
    -- Completion popup
    NormalPopup = {
      bg = colors.dark1,
      fg = colors.light0,
    },
  }
}

vim.cmd.colorscheme('gruvbox')
