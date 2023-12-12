local function toggle_number()
  ---@diagnostic disable-next-line: undefined-field
  return vim.b.toggle_number
end

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }

  vim.keymap.set('t', '<C-n>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-q>', '<cmd>q<cr>', opts)

  vim.keymap.set('n', 'q', '<cmd>q<cr>', opts)

  vim.o.number = false
  vim.o.relativenumber = false

  -- keymaps only for normal terminals
  if toggle_number() == nil then
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  end
end

-- set keymap for every terminal
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- layzgit terminal
local terminal = require('toggleterm.terminal').Terminal
local lazygit_terminal = terminal:new {
  cmd = 'lazygit',
  hidden = true,
  float_opts = {
    border = 'none'
  },
  direction = 'float'
}

-- floating terminal array
local terminal_index = 1

local function next()
  terminal_index = terminal_index + 1
  vim.cmd(terminal_index .. 'ToggleTerm')
end

local function prev()
  if terminal_index == 1 then return end

  terminal_index = terminal_index - 1
  vim.cmd(terminal_index .. 'ToggleTerm')
end

local function current()
  vim.cmd(terminal_index .. 'ToggleTerm')
end

local function on_open(term)
  if (term == lazygit_terminal) then return end

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

local colors = require('tokyonight.colors').setup()
print(colors.border_highlight)
require('toggleterm').setup {
  close_on_exit = true,
  shade_terminals = false,
  on_open = on_open,
  highlights = {
    FloatBorder = {
      guibg = colors.bg_float,
      guifg = colors.border_highlight,
    },
  },
  float_opts = {
    border = 'curved'
  },
  direction = 'float'
}

local function opts(desc)
  return { desc = 'Terminal: ' .. desc, noremap = true, silent = true }
end

vim.keymap.set('n', '<leader>tf', current, opts('[T]erminal [F]loating'))
vim.keymap.set('n', '<leader>tv', '<cmd>bo vs | te<cr>', opts('[T]erminal [V]ertical'))
vim.keymap.set('n', '<leader>th', '<cmd>bo sp | te<cr>', opts('[T]erminal [H]orizontal'))

local function lazygit()
  lazygit_terminal:toggle()
end

vim.keymap.set('n', '<leader>tg', lazygit, opts('[T]erminal [G]it'))
