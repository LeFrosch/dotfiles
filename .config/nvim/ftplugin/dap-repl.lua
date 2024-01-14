local dap = require('dap')

local opts = { buffer = 0 }

vim.keymap.set('i', '<C-q>', dap.repl.close, opts)
vim.keymap.set('n', '<C-q>', dap.repl.close, opts)
vim.keymap.set('n', 'q', dap.repl.close, opts)
