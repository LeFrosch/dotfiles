local colors = require('gruvbox').palette

require('toggleterm').setup {
  close_on_exit = true,
  shade_terminals = false,
  highlights = {
    FloatBorder = {
      guifg = colors.light0,
    },
  },
  float_opts = {
    border = 'curved'
  },
  direction = 'float',
  persist_mode = false,
  start_in_insert = true,
}

local function toggle_number()
  ---@diagnostic disable-next-line: undefined-field
  return vim.b.toggle_number
end

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }

  vim.keymap.set('t', '<C-n>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-q>', '<cmd>q<cr>', opts)

  vim.keymap.set('n', 'q', '<cmd>q<cr>', opts)
  vim.keymap.set('n', '<C-q>', '<cmd>q<cr>', opts)

  vim.keymap.set('v', '<C-q>', '<cmd>q<cr>', opts)

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

local function lazygit()
  lazygit_terminal:toggle()
end

-- switch terminal implementation
local switch_terminal = require('impl.switchterm')

local function switch_send_n()
  local row = unpack(vim.api.nvim_win_get_cursor(0))
  switch_terminal.send(vim.fn.getline(row))
end

local function switch_send_v()
  local text = require('config.util').get_visual_selection()
  switch_terminal.send(text)
end

local function opts(desc)
  return { desc = 'Terminal: ' .. desc, noremap = true, silent = true }
end

vim.keymap.set('n', '<leader>tg', lazygit, opts('[T]erminal [G]it'))
vim.keymap.set('n', '<leader>tv', '<cmd>bo vs | te<cr>', opts('[T]erminal [V]ertical'))
vim.keymap.set('n', '<leader>th', '<cmd>bo sp | te<cr>', opts('[T]erminal [H]orizontal'))

vim.keymap.set('n', '<leader>tf', switch_terminal.toggle, opts('[T]erminal [F]loating'))
vim.keymap.set('n', '<leader>ts', switch_send_n, opts('[T]erminal [S]end current line'))
vim.keymap.set('v', '<leader>ts', switch_send_v, opts('[T]erminal [S]end selction'))
