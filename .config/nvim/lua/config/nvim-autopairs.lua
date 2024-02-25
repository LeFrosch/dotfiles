local autopair = require('nvim-autopairs')

autopair.setup {}

-- configure completion for autopair
local autocmp = require('nvim-autopairs.completion.cmp')

require('cmp').event:on(
  'confirm_done',
  autocmp.on_confirm_done()
)

local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

-- rules for triple quotes
local function quoteRule(char)
  local text = char .. char .. char

  autopair.remove_rule(text)

  autopair.add_rules {
    Rule(text, text):with_pair(cond.not_before_text(text)):with_pair(cond.not_after_text(text))
  }
end

quoteRule("'")
quoteRule('"')
quoteRule('`')

-- rules for || in zig
autopair.add_rule(Rule('|', '|', 'zig'))
