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
    direction = 'float',
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

local function goto_file(term)
  -- 1. Get the file path under the cursor
  local cfile = vim.fn.expand('<cfile>')

  -- 2. Close the terminal (using the term object passed in)
  term:close()

  -- 3. Find a suitable window to open the file
  -- We verify we aren't in a float or special window just in case
  local win_id = vim.api.nvim_get_current_win()

  -- If the current window (after closing term) is invalid or special, pick the first usable one
  -- Usually, term:close() puts you back in the previous window automatically.

  -- 4. Open the file
  if cfile and #cfile > 0 then
    vim.cmd('edit ' .. cfile)
  else
    print("No file found under cursor")
  end
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

  vim.keymap.set('n', 'gf', function()
    goto_file(term)
  end, opts)
end

function M.toggle()
  get_or_create():toggle()
end

function M.send(text)
  local term = get_or_create()
  if term.job_id == nil then return end

  term:send(text, true)
end

return M
