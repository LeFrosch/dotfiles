vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
  callback = function()
    require('lint').try_lint('codespell')
  end,
})
