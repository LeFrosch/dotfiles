require('which-key').setup {
  icons = {
    mappings = false,
    rules = false,
    breadcrumb = '>>',
    separator = '>',
    ellipsis = '...',
    keys = {
      Up = '<up>',
      Down = '<down>',
      Left = '<left>',
      Right = '<right>',
      C = '<c>',
      M = '<m>',
      D = '<d>',
      S = '<s>',
      CR = '<cr>',
      Esc = '<esc>',
      ScrollWheelDown = '<scrollwheeldown>',
      ScrollWheelUp = '<scrollwheelup>',
      NL = '<nl>',
      BS = '<bs>',
      Space = '<space>',
      Tab = '<tab>',
      F1 = '<f1>',
      F2 = '<f2>',
      F3 = '<f3>',
      F4 = '<f4>',
      F5 = '<f5>',
      F6 = '<f6>',
      F7 = '<f7>',
      F8 = '<f8>',
      F9 = '<f9>',
      F10 = '<f10>',
      F11 = '<f11>',
      F12 = '<f12>',
    },
  }
}

require('which-key').add {
  mode = { 'n' },
  { '<leader>b',  group = '[B]uffer' },
  { '<leader>c',  group = '[C]ode' },
  { '<leader>d',  group = '[D]ebugger' },
  { '<leader>dk', group = '[D]ebugger [K]onfiguration' },
  { '<leader>f',  group = '[F]ile Explorer' },
  { '<leader>g',  group = '[G]it' },
  { '<leader>i',  group = '[I]nspection' },
  { '<leader>r',  group = '[R]efactor' },
  { '<leader>s',  group = '[S]earch' },
  { '<leader>t',  group = '[T]erminal' },
  { 'g',          group = '[G]oto' },
}

require('which-key').add {
  mode = { 'n' },
  { '<leader>s', group = '[S]earch' },
}
