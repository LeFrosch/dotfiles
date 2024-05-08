local action_state = require('telescope.actions.state')
local fb_utils = require('telescope._extensions.file_browser.utils')

local M = {}

local function yank_path(relative)
  local file = action_state.get_selected_entry()
  if not file then
    fb_utils.notify("action.yank_path", { msg = "No selection to be yanked!", level = "WARN" })
    return
  end

  local path
  if relative then
    path = file.Path:make_relative()
  else
    path = file.Path:absolute()
  end

  vim.print(path)
  vim.fn.setreg('"', path)
end

function M.yank_path_relative()
  yank_path(true)
end

function M.yank_path_absolute()
  yank_path(false)
end

return M
