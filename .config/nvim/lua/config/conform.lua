local conform = require('conform')

conform.setup {
  formatters_by_ft = {
    json = { 'prettier' },
    yaml = { 'prettier' },
  }
}

local function format()
  conform.format { lsp_fallback = true }
end

local opts = { desc = 'LSP*: [C]ode [F]ormat', noremap = true }

vim.keymap.set('n', '<leader>cf', format, opts)
vim.keymap.set('v', '<leader>cf', format, opts)
