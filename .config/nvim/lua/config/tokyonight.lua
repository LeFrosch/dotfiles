---@diagnostic disable: missing-fields
require('tokyonight').setup {
  style = 'moon',
  on_colors = function(c)
    c.bg_float = c.bg
  end,
  on_highlights = function(hl, c)
    hl.FloatBorder = {
      bg = c.bg_float,
      fg = c.border_highlight,
    }
    hl.TelescopeBorder = {
      bg = c.bg_float,
      fg = c.border_highlight,
    }
    hl.NormalPopup = {
      bg = c.bg_popup,
      fg = c.fg_float,
    }
  end,
}

vim.cmd.colorscheme('tokyonight')

