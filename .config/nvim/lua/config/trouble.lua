require('trouble').setup {
  icons = false,
  signs = {
    error = "error",
    warning = "warn",
    hint = "hint",
    information = "info"
  },
  use_diagnostic_signs = false,
  action_keys = {
    jump_close = { 'l' },
    toggle_fold = { 'h' },
  },
}

local mapper = function(mode, key, result, desc)
  vim.keymap.set(
    mode, key, result,
    { noremap = true, silent = true, desc = 'Diagnostics: ' .. desc }
  )
end

local trouble = require('trouble')

local function open_float()
  local _, win = vim.diagnostic.open_float()
  if win == nil then return end

  vim.api.nvim_win_set_option(win, 'winblend', 0)
  vim.api.nvim_win_set_option(win, 'winhl', 'NormalFloat:NormalPopup')
end

mapper('n', '[d', vim.diagnostic.goto_prev, 'Go to previous message')
mapper('n', ']d', vim.diagnostic.goto_next, 'Go to next message')
mapper('n', '<leader>df', open_float, '[D]iagnostic [F]loating')

mapper('n', '<leader>dl', function() trouble.toggle() end, '[D]iagnostic [L]ist')
mapper('n', '<leader>dd', function() trouble.toggle('document_diagnostics') end, '[D]iagnostic [D]ocument List')
mapper('n', '<leader>dw', function() trouble.toggle('workspace_diagnostics') end, '[D]iagnostic [W]orkspace List')
