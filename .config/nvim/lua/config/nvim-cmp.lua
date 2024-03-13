local cmp = require('cmp')
local snip = require('luasnip')

snip.config.setup()

cmp.setup {
  snippet = {
    expand = function(args)
      snip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered {
      border = 'none',
      winhighlight = 'CursorLine:Visual,Search:None,NormalFloat:NormalPopup',
    },
    documentation = cmp.config.window.bordered {
      border = 'none',
      winhighlight = 'CursorLine:Visual,Search:None,NormalFloat:NormalPopup',
    },
  },
  completion = {
    completionopt = "menu,menuone,noselect"
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-y>'] = cmp.mapping.confirm { select = true },
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-l>'] = cmp.mapping(function()
      if snip.expand_or_locally_jumpable() then
        snip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if snip.locally_jumpable(-1) then
        snip.jump(-1)
      end
    end, { 'i', 's' })
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }
}
