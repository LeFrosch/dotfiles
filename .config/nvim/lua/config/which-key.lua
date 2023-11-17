local normal = {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]oto', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = '[F]ile Explorer', _ = 'which_key_ignore' },
  ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]erminal', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]iagnostic', _ = 'which_key_ignore' },
}

local visual = {
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
}

require('which-key').register(normal, { mode = 'n' })
require('which-key').register(visual, { mode = 'v' })
