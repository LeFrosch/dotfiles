local dap = require('dap')
local sel = require('impl.dap-selector')

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
    name = 'DEFAULT',
    request = 'launch',
    program = '${workspaceFolder}/main.go'
  }
}

--- DART  --------------------------------------------------------------------------------

dap.adapters.dart = {
  type = 'executable',
  command = 'dart',
  args = { 'debug_adapter' }
}
dap.adapters.flutter = {
  type = 'executable',
  command = 'flutter',
  args = { 'debug_adapter' }
}

dap.configurations.dart = {
  {
    type = 'dart',
    request = 'launch',
    name = 'DEFAULT',
    dartSdkPath = '~/.local/opt/flutter/bin/cache/dart-sdk/bin/dart',
    program = '${workspaceFolder}/lib/main.dart',
    cwd = '${workspaceFolder}',
  }
}
dap.configurations.flutter = {
  {
    type = 'flutter',
    request = 'launch',
    name = 'DEFAULT',
    dartSdkPath = '~/.local/opt/flutter/bin/cache/dart-sdk/bin/dart',
    flutterSdkPath = '~/.local/opt/flutter/bin/flutter',
    program = '${workspaceFolder}/lib/main.dart',
    cwd = '${workspaceFolder}',
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
vim.keymap.set('n', '<leader>ds', dap.step_over, opts('[D]ebugger [S]tep Over'))
vim.keymap.set('n', '<leader>di', dap.step_into, opts('[D]ebugger Step [I]nto'))
vim.keymap.set('n', '<leader>do', dap.step_out, opts('[D]ebugger Step [O]ut'))
vim.keymap.set('n', '<leader>dt', dap.run_to_cursor, opts('[D]ebugger continue [T]ill Cursor'))
vim.keymap.set('n', '<leader>dq', dap.close, opts('[D]ebugger [Q]uit'))
vim.keymap.set('n', '<leader>dr', open_rpel, opts('[D]ebugger Toggle [R]EPL'))

vim.keymap.set('n', '<leader>dks', sel.select_configuration, opts('[D]ebugger [K]onfiguration [S]elect'))
vim.keymap.set('n', '<leader>dkr', sel.run_last_configuration, opts('[D]ebugger [K]onfiguration [R]un last'))
vim.keymap.set('n', '<leader>dke', sel.open_launchjs, opts('[D]ebugger [K]onfiguration [E]dit'))
