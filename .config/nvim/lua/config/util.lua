local M = {}

function M.send_lsp_command(name, command, callback, bufnr)
  local clients = vim.lsp.get_active_clients { name = name }
  local client = clients[1]

  assert(client ~= nil, "no client for lsp " .. name .. " found")

  client.request('workspace/executeCommand', command, callback, bufnr or 0)
end

function M.get_visual_selection()
  local backup = vim.fn.getreg('a')

  vim.cmd('silent! normal! "ay') --gv
  local text = vim.fn.getreg('a')

  vim.fn.setreg('a', backup)

  return text
end

return M
