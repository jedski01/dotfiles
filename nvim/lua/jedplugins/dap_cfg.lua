return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	config = function()
		local dapui = require("dapui")

		dapui.setup({
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.33 },
						{ id = "breakpoints", size = 0.17 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					size = 0.33,
					position = "right",
				},
				{
					elements = {
						{ id = "repl", size = 0.45 },
						{ id = "console", size = 0.55 },
					},
					size = 0.27,
					position = "bottom",
				},
			},
		})

		-- key mappings
		local dap = require("dap")
		local silentopts = { noremap = true, silent = true }

		-- keybindings
		vim.api.nvim_set_keymap("n", "<F8>", "<cmd> lua require('dap').continue()<CR>", silentopts)
		vim.api.nvim_set_keymap("n", "<F7>", "<cmd> lua require('dap').toggle_breakpoint()<CR>", silentopts)
		vim.api.nvim_set_keymap("n", "<F19>", "<cmd> lua require('dap').clear_breakpoints()<CR>", silentopts)
		vim.api.nvim_set_keymap("n", "<F10>", "<cmd> lua require('dap').step_over()<CR>", silentopts)
		vim.api.nvim_set_keymap("n", "<F11>", "<cmd> lua require('dap').step_into()<CR>", silentopts)
		vim.api.nvim_set_keymap("n", "<F12>", "<cmd> lua require('dap').step_out()<CR>", silentopts)
		vim.api.nvim_set_keymap(
			"n",
			"<F20>",
			"<cmd> lua require('dap').disconnect()<CR><cmd>lua require('dap').close()<CR>",
			silentopts
		)
		vim.api.nvim_set_keymap("n", "<F5>", "<cmd> lua require('dapui').toggle()<CR>", silentopts)

		-- Automaticlly open dap ui when dap starts
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		-- Automaticlly close dap ui when dap terminated
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.disconnect["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- vscode-js
		for _, language in ipairs({ "typescript", "javascript" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
          sourceMaps = true,
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = 'Start Chrome with "localhost"',
					url = "http://localhost:3000",
					webRoot = "${workspaceFolder}",
					userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
				},
        {
          name = "Remote  Attach",
          type = "node",
          request = "attach",
          port = function()
            return vim.fn.input("Port: ")
          end,
          address = function()
            return vim.fn.input("Address: ")
          end,
          sourceMaps = true,
          localRoot = "${workspaceFolder}",
        }
			}
		end

		-- C/C++
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
					return vim.fn.input("Extra args: ")
				end,
				minDebuggerPath = "usr/bin/gdb",
				cwd = "${workspaceFolder}",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}

		dap.configurations.cpp = dap.configurations.c
	end,
}
