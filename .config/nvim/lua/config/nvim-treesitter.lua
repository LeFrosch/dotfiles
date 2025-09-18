require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'lua' },

  sync_install = true,
  auto_install = true,

  highlight = {
    enable = true,
  },

  ignore_install = { "dockerfile" },
}

require('treesitter-context').setup {
  enable = true,
  max_lines = 20,
  multiline_threshold = 4,
}
