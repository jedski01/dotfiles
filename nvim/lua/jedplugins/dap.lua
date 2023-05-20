require("mason-nvim-dap").setup({
	ensure_installed = { "cppdbg", "js-debug-adapter", "python" },
})

local dapui = require("dapui")

dapui.setup()

-- key mappings
local dap = require("dap")
local silentopts = { noremap = true, silent = true }

-- keybindings
vim.api.nvim_set_keymap("n", "<F8>", "<cmd> lua require('dap').continue()<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<F7>", "<cmd> lua require('dap').toggle_breakpoint()<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<F10>", "<cmd> lua require('dap').step_over()<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<F11>", "<cmd> lua require('dap').step_into()<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<S-F11>", "<cmd> lua require('dap').step_out()<CR>", silentopts)

-- Automaticlly open dap ui when dap starts
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
