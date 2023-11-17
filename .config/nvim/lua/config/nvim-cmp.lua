---@diagnostic disable: missing-fields
local cmp = require('cmp')
local snip = require('luasnip')

snip.config.setup()

cmp.setup {
  snippet = {
    expand = function(args)
      snip.lsp_expand(args.body)
    end,
  },
  completion = {
    completionopt = "menu,menuone,noselect"
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
  }
}
