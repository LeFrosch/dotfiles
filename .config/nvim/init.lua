vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- bootstrap lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- general settings
vim.o.errorbells = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.hlsearch = true
vim.o.undofile = true
vim.o.autowriteall = true

vim.o.completeopt = 'menuone,noselect'

vim.o.mouse = ''

-- mappings
local mapper = function(mode, key, result, desc)
  vim.keymap.set(
    mode, key, result,
    { noremap = true, silent = true, desc = desc }
  )
end

-- disable sapce
mapper('n', '<Space>', '<Nop>')
mapper('v', '<Space>', '<Nop>')

-- disable arrows
mapper('', '<up>', '<nop>')
mapper('', '<down>', '<nop>')
mapper('', '<left>', '<nop>')
mapper('', '<right>', '<nop>')

-- utils mappings
mapper('i', 'jj', '<ESC>')
mapper('n', '<C-s>', '<cmd>wa<cr>', 'Save all')

-- buffer mappings
mapper('n', '<leader>bv', '<cmd>bo vs<cr>', '[B]uffer Split [V]ertical')
mapper('n', '<leader>bh', '<cmd>bo sp<cr>', '[B]uffer Split [H]orizontal')

-- autosave
vim.cmd('autocmd! BufLeave * if &modifiable && &buftype ==# "" | :update | endif')

-- plugins
require('config.lazy')
