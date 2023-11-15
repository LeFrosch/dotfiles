require('neodev').setup()
require('mason').setup()
require('mason-lspconfig').setup()

local function on_attach(_, bufnr)
  local function opts(desc)
    return { desc = 'LSP: ' .. desc, buffer = bufnr, noremap = true }
  end

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts('[R]e[n]ame'))

  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts('[C]ode [A]ction'))
  vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, opts('[C]ode [F]ormat'))

  vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts('[G]oto [D]efinition'))
  vim.keymap.set('n', '<leader>gD', vim.lsp.buf.definition, opts('[G]oto [D]eclaration'))

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts('Hover Documentation'))
end


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('lspconfig').lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    }
  }
}

require('lspconfig').dartls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
