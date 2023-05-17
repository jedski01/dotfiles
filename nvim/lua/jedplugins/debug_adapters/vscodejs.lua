local DEBUGGER_PATH = vim.fn.stdpath "data" .. "/site/pack/packer/opt/vscode-js-debug"

require('dap-vscode-js').setup({
  debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
  debugger_cmd = { 'js-debug-adapter' },
  adapters = { 'pwa-node' }
})

for _, language in ipairs({ 'typescript', 'javascript' }) do
  require('dap').configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
      protocol = 'inspector',
      console = 'integratedTerminal'
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    }
  }
end
