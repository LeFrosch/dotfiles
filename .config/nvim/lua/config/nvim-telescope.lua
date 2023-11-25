local api = require('telescope.builtin')
local actions = require('telescope.actions')
local fb_actions = require('telescope._extensions.file_browser.actions')

require('telescope').setup {
  defaults = {
    initial_mode = 'normal',
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
      n = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['l'] = actions.select_default,
        ['q'] = actions.close,
      }
    }
  },
  extensions = {
    file_browser = {
      grouped = true,
      hijack_netrw = true,
      display_stat = { date = true, size = true, mode = false },
      dir_icon = ' ',
      mappings = {
        ['n'] = {
          ['h'] = fb_actions.goto_parent_dir,
          ['H'] = fb_actions.toggle_hidden,
          ['a'] = fb_actions.select_all,
          ['s'] = actions.toggle_selection,
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
    ignore_current_buffer = true,
    only_cwd = true,
    sort_lastused = true,
  }
end

keymap_search('<leader>?', api.oldfiles, '[?] Find recently opened files')
keymap_search('<leader><space>', switcher, '[ ] Switcher')
keymap_search('<leader>/', api.current_buffer_fuzzy_find, '[/] Fuzzily search in current buffer')
keymap_search('<leader>sf', api.find_files, '[S]earch [F]iles')
keymap_search('<leader>sh', api.help_tags, '[S]earch [H]elp')
keymap_search('<leader>sw', api.grep_string, '[S]earch current [W]ord')
keymap_search('<leader>sg', api.live_grep, '[S]earch by [G]rep')
keymap_search('<leader>sd', api.diagnostics, '[S]earch [D]iagnostics')
keymap_search('<leader>sr', api.resume, '[S]earch [R]esume')

vim.keymap.set('n', '<leader>fe', '<cmd>Telescope file_browser<cr>', { desc = '[F]ile [E]xplorer' })
vim.keymap.set('n', '<leader>fl', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>', { desc = '[F]ile [L]ocal Browser' })

vim.keymap.set('n', '<leader>gs', api.git_status, { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gc', api.git_commits, { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<leader>gb', api.git_branches, { desc = '[G]it [B]ranches' })
