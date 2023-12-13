require('nvim-autopairs').setup {}

local autocmp = require('nvim-autopairs.completion.cmp')

require('cmp').event:on(
  'confirm_done',
  autocmp.on_confirm_done()
)
