local function mapper(mode, key, result, desc)
  vim.keymap.set(
    mode, key, result,
    { noremap = true, silent = true, desc = desc }
  )
end

-- disable sapce
mapper('n', '<Space>', '<Nop>')
mapper('v', '<Space>', '<Nop>')

-- disable arrows
mapper('', '<up>', '<nop>')
mapper('', '<down>', '<nop>')
mapper('', '<left>', '<nop>')
mapper('', '<right>', '<nop>')

-- utils mappings
mapper('i', 'jj', '<ESC>')
mapper('n', '<C-s>', '<cmd>wa<cr>')
mapper('v', 'Y', '"+y')

-- buffer mappings
mapper('n', '<leader>bv', '<cmd>bo vs<cr>', '[B]uffer Split [V]ertical')
mapper('n', '<leader>bh', '<cmd>bo sp<cr>', '[B]uffer Split [H]orizontal')
