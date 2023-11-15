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
vim.o.scrolloff = 8
vim.o.hlsearch = true
vim.o.undofile = true

vim.o.completeopt = 'menuone,noselect'

-- mappings
local mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

mapper('n', '<Space>', '<Nop>')
mapper('v', '<Space>', '<Nop>')

mapper('', '<up>', '<nop>')
mapper('', '<down>', '<nop>')
mapper('', '<left>', '<nop>')
mapper('', '<right>', '<nop>')

mapper('i', 'jj', '<ESC>')

-- plugins
require('config.lazy')
