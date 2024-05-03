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

-- settings
vim.o.errorbells = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.hlsearch = true
vim.o.undofile = true
vim.o.autowriteall = true
vim.o.wrap = false

vim.o.completeopt = 'menuone,noselect'
vim.o.mouse = ''

vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- autosave
vim.cmd('autocmd! BufLeave * if &modifiable && &buftype ==# "" | :update! | endif')

-- mappings
require('mapping')

-- plugins
require('config.lazy')
