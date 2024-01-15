local dap = require('dap')

local t_pickers = require('telescope.pickers')
local t_finders = require('telescope.finders')
local t_make_entry = require('telescope.make_entry')
local t_previewers = require('telescope.previewers')
local t_actions = require('telescope.actions')
local t_actions_state = require('telescope.actions.state')
local t_config = require('telescope.config')
local t_utils = require('telescope.utils')

local launchjs_path = '.nvim/launch.json'

local launchjs_template = [[
{
    "version": "0.2.0",
    "configurations": [
    ]
}
]]

local M = {}

local function create_launchjs()
  local dir = launchjs_path:match('.*/')
  os.execute('mkdir -p ' .. dir)

  local file = io.open(launchjs_path, 'w')
  assert(file, 'could not create launchjs file')

  file:write(launchjs_template)
  file:close()
end

function M.open_launchjs()
  local stat = vim.loop.fs_stat(launchjs_path)
  if not stat then
    create_launchjs()
  end

  vim.cmd('edit ' .. launchjs_path)
end

local last_configuration = nil

local function run_configuration(configuration)
  last_configuration = configuration
  dap.run(configuration)
end

function M.run_last_configuration()
  if last_configuration then
    run_configuration(last_configuration)
  end
end

local function load_configurations()
  local ok, err = pcall(require('dap.ext.vscode').load_launchjs, launchjs_path, {})
  if not ok then
    vim.notify(err)
    return
  end

  local objs = {}

  for group, configs in pairs(dap.configurations) do
    for _, config in ipairs(configs) do
      table.insert(objs, {
        group = group,
        config = config,
      })
    end
  end

  return objs
end

local function create_finder(results, opts)
  local function maker(entry)
    local name = string.upper(entry.group) .. ": " .. entry.config.name

    return t_make_entry.set_default_entry_mt({
      value = entry.config,
      text = vim.inspect(entry.config),
      display = name,
      ordinal = name,
    }, opts)
  end

  return t_finders.new_table {
    results = results,
    entry_maker = maker,
  }
end

local function create_previewer()
  return t_previewers.new_buffer_previewer {
    title = 'Configuration',
    define_preview = function(self, entry, _)
      local lines = vim.split(vim.inspect(entry.value), '\n')

      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
      vim.api.nvim_buf_set_option(self.state.bufnr, "filetype", "lua")
    end
  }
end

local function create_mappings()
  t_actions.select_default:replace(function(prompt_bufnr)
    local selection = t_actions_state.get_selected_entry()
    if not selection then
      t_utils.__warn_no_selection('nvim-dap')
    end

    local configuration = selection.value
    t_actions.close(prompt_bufnr)

    run_configuration(configuration)
  end)
end

function M.select_configuration(opts)
  local configurations = load_configurations()

  local picker = t_pickers.new(opts, {
    prompt_title = "Select Configuration",
    finder = create_finder(configurations, opts),
    previewer = create_previewer(),
    sorter = t_config.values.generic_sorter(opts),
    attach_mappings = function(_)
      create_mappings()
      return true
    end
  })

  picker:find()
end

return M
