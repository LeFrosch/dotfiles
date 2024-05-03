require('mason').setup {
  ui = {
    border = 'rounded'
  }
}

require('mason-lspconfig').setup {
  automatic_installation = false,
}

require('neodev').setup()

local telescope = require('telescope.builtin')

local function on_attach(_, bufnr)
  local function opts(desc)
    return { desc = 'LSP: ' .. desc, buffer = bufnr, noremap = true }
  end

  local function search(func)
    return function()
      func { initial_mode = 'insert' }
    end
  end

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts('[R]e[n]ame'))

  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts('[C]ode [A]ction'))
  vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, opts('[C]ode [F]ormat'))

  vim.keymap.set('n', 'gd', search(telescope.lsp_definitions), opts('[G]oto [D]efinition'))
  vim.keymap.set('n', 'gr', search(telescope.lsp_references), opts('[G]oto [R]eferences'))
  vim.keymap.set('n', 'gI', search(telescope.lsp_implementations), opts('[G]oto [I]mplementations'))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts('[G]oto [D]eclaration'))

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts('Hover Documentation'))
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts('Signature Documentation'))
end

local function on_attach_dart(_, bufnr)
  on_attach(nil, bufnr)

  local function opts(desc)
    return { desc = 'Dart: ' .. desc, buffer = bufnr, noremap = true }
  end

  local reload_cmd = [[<cmd>wa | silent execute '!kill -s USR1 "$(pgrep -f flutter_tools.snapshot\ run)"'<cr>]]
  vim.keymap.set('n', '<leader>cr', reload_cmd, opts('Flutter Hot [R]eload'))
end

local servers = {
  -- Lua
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },

  -- Dart
  dartls = {
    settings = {
      dart = {
        lineLength = 100
      }
    },
    on_attach = on_attach_dart,
  },

  -- Java
  jdtls = {},

  -- C
  clangd = {},

  -- Elixir
  elixirls = {
    settings = {
      elixirLS = {
        dialyzerEnabled = false
      }
    }
  },

  -- Go
  gopls = {},

  -- Zig
  zls = {},

  -- Python
  pylsp = {},

  -- Haskell,
  hls = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for server, settings in pairs(servers) do
  require('lspconfig')[server].setup {
    capabilities = capabilities,
    on_attach = settings.on_attach or on_attach,
    settings = settings.settings,
  }
end
