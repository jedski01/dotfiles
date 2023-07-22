return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		require("mason-nvim-dap").setup({
			ensure_installed = { "cppdbg" },
		})

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
	end,
}
