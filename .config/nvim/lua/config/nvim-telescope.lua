local api = require('telescope.builtin')
local te_actions = require('telescope.actions')
local fb_actions = require('telescope._extensions.file_browser.actions')
local my_actions = require('impl.telescope-actions')

require('telescope').setup {
  defaults = {
    initial_mode = 'normal',
    mappings = {
      i = {
        ['<C-j>'] = te_actions.move_selection_next,
        ['<C-k>'] = te_actions.move_selection_previous,
        ['<C-q>'] = te_actions.close,
        ['<C-f>'] = te_actions.send_to_qflist,
      },
      n = {
        ['<C-j>'] = te_actions.move_selection_next,
        ['<C-k>'] = te_actions.move_selection_previous,
        ['<C-f>'] = te_actions.send_to_qflist,
        ['<C-q>'] = te_actions.close,
        ['q'] = te_actions.close,
      }
    }
  },
  extensions = {
    file_browser = {
      grouped = true,
      hijack_netrw = true,
      display_stat = { date = true, size = true, mode = false },
      dir_icon = ' ',
      respect_gitignore = false,
      mappings = {
        ['n'] = {
          ['l'] = te_actions.select_default,
          ['h'] = fb_actions.goto_parent_dir,
          ['H'] = fb_actions.toggle_hidden,
          ['a'] = fb_actions.select_all,
          ['s'] = te_actions.toggle_selection,
          ['p'] = my_actions.yank_path_relative,
          ['P'] = my_actions.yank_path_absolute,
        }
      },
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

local function visual_selcteion()
  local _, ls, cs = unpack(vim.fn.getpos('v'))
  local _, le, ce = unpack(vim.fn.getpos('.'))
  local lines = vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})

  return table.concat(lines)
end

local function normal_search(func)
  return function()
    func { initial_mode = 'insert' }
  end
end

local function visual_search(func)
  return function()
    func {
      initial_mode = 'insert',
      default_text = visual_selcteion()
    }
  end
end

local function keymap_search(key, func, desc)
  vim.keymap.set('n', key, normal_search(func), { desc = desc })
  vim.keymap.set('v', key, visual_search(func), { desc = desc })
end

local function switcher()
  api.buffers {
    sort_mru = true,
    ignore_current_buffer = true,
  }
end

local function class_search()
  api.lsp_dynamic_workspace_symbols {
    symbols = 'class',
  }
end

keymap_search('<leader>?', api.oldfiles, '[?] Find recently opened files')
keymap_search('<leader><space>', switcher, '[ ] Switcher')
keymap_search('<leader>/', api.current_buffer_fuzzy_find, '[/] Fuzzily search in current buffer')
keymap_search('<leader>sf', api.find_files, '[S]earch [F]iles')
keymap_search('<leader>sh', api.help_tags, '[S]earch [H]elp')
keymap_search('<leader>sg', api.live_grep, '[S]earch by [G]rep')
keymap_search('<leader>sr', api.resume, '[S]earch [R]esume')
keymap_search('<Leader>ss', api.lsp_dynamic_workspace_symbols, '[S]earch [S]ymbols')
keymap_search('<Leader>sc', class_search, '[S]earch [C]lass')

keymap_search('<leader>ds', api.diagnostics, '[D]iagnostics [S]earch')

vim.keymap.set('n', '<leader>fe', '<cmd>Telescope file_browser<cr>', { desc = '[F]ile [E]xplorer' })
vim.keymap.set('n', '<leader>fl', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>',
  { desc = '[F]ile [L]ocal Browser' })

vim.keymap.set('n', '<leader>gs', api.git_status, { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gc', api.git_commits, { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<leader>gb', api.git_branches, { desc = '[G]it [B]ranches' })
