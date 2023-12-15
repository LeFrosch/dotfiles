local M = {}

local terminal = require('toggleterm.terminal').Terminal

local terminal_array = {}
local terminal_index = 1

-- forward definition for the open callback
local on_open

local function get_or_create()
  local term = terminal_array[terminal_index]
  if (term ~= nil) then return term end

  term = terminal:new {
    on_open = on_open,
  }
  terminal_array[terminal_index] = term

  return term
end

local function next()
  terminal_index = terminal_index + 1
  get_or_create():open()
end

local function prev()
  if terminal_index == 1 then return end

  terminal_index = terminal_index - 1
  get_or_create():open()
end

on_open = function(term)
  -- workaround because the cmd wasn't working 
  vim.fn.timer_start(1, function()
    vim.cmd('startinsert!')
  end)

  local opts = { buffer = term.bufnr }

  vim.keymap.set('t', '<C-k>', next, opts)
  vim.keymap.set('n', '<C-k>', next, opts)
  vim.keymap.set('t', '<C-l>', next, opts)
  vim.keymap.set('n', '<C-l>', next, opts)
  vim.keymap.set('t', '<C-h>', prev, opts)
  vim.keymap.set('n', '<C-h>', prev, opts)
  vim.keymap.set('t', '<C-j>', prev, opts)
  vim.keymap.set('n', '<C-j>', prev, opts)
end

function M.toggle()
  get_or_create():toggle()
end

return M
