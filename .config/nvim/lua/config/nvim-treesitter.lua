require('nvim-treesitter').install { 'c', 'lua' }

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args) pcall(vim.treesitter.start, args.buf) end,
})

require('treesitter-context').setup {
  enable = true,
  max_lines = 20,
  multiline_threshold = 4,
}
