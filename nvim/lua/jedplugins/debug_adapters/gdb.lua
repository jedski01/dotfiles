local dap = require("dap")

-- Follow this guide for initial configuration
-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)
dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "OpenDebugAD7",
	options = {
		detached = false,
	},
}

dap.configurations.c = {
	{
		name = "Connect to GDB server",
		type = "cppdbg",
		request = "launch",
		MIMode = "gdb",
		miDebuggerServerAddress = function()
			return vim.fn.input("Remote GDB Server: ")
		end,
    miDebuggerArgs = function()
      return vim.fn.input('Extra args: ')
    end,
		minDebuggerPath = "usr/bin/gdb",
		cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
	},
}

dap.configurations.cpp = dap.configurations.c
