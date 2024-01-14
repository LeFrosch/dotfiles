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
    { noremap = true, silent = true, desc = desc }
  )
end

local trouble = require('trouble')

local function open_float()
  local _, win = vim.diagnostic.open_float()
  if win == nil then return end

  vim.api.nvim_win_set_option(win, 'winblend', 0)
  vim.api.nvim_win_set_option(win, 'winhl', 'NormalFloat:NormalPopup')
end

mapper('n', '[i', vim.diagnostic.goto_prev, 'Go to previous inspection')
mapper('n', ']i', vim.diagnostic.goto_next, 'Go to next inspection')
mapper('n', '<leader>if', open_float, '[I]nspection [F]loating')

mapper('n', '<leader>il', function() trouble.toggle() end, '[I]nspection [L]ist')
mapper('n', '<leader>id', function() trouble.toggle('document_diagnostics') end, '[I]nspection [D]ocument List')
mapper('n', '<leader>iw', function() trouble.toggle('workspace_diagnostics') end, '[I]nspection [W]orkspace List')
