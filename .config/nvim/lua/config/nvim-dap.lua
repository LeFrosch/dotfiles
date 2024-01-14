local dap = require('dap')

--- GO ----------------------------------------------------------------------------------

dap.adapters.go = {
  type = 'server',
  host = '127.0.0.1',
  port = 44001,
  executable = {
    command = 'dlv',
    args = { 'dap', '-l', '127.0.0.1:44001' }
  }
}

dap.configurations.go = {
  {
    type = 'go',
    name = 'Debug',
    request = 'launch',
    program = '${workspaceFolder}/main.go'
  }
}

vim.fn.sign_define('DapStopped', { text = '>', texthl = '', linehl = '', numhl = '' })

local function opts(desc)
  return { desc = 'DAP: ' .. desc, noremap = true }
end

local function open_rpel()
  local _, window = dap.repl.open()

  vim.api.nvim_set_current_win(window)
  vim.cmd('startinsert!')
end

vim.keymap.set('n', '<leader>cb', dap.toggle_breakpoint, opts('[C]ode [B]reakpoint'))

vim.keymap.set('n', '<leader>dc', dap.continue, opts('[D]ebugger [C]ontinue'))
vim.keymap.set('n', '<leader>dn', dap.step_over, opts('[D]ebugger Step [N]ext'))
vim.keymap.set('n', '<leader>di', dap.step_into, opts('[D]ebugger Step [I]nto'))
vim.keymap.set('n', '<leader>do', dap.step_out, opts('[D]ebugger Step [O]ut'))
vim.keymap.set('n', '<leader>dt', dap.run_to_cursor, opts('[D]ebugger continue [T]ill Cursor'))
vim.keymap.set('n', '<leader>ds', dap.close, opts('[D]ebugger [S]top'))
vim.keymap.set('n', '<leader>dr', open_rpel, opts('[D]ebugger Toggle [R]EPL'))
