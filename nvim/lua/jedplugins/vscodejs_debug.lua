return {
	"mfussenegger/nvim-dap",
	ft = { "typescript", "javascript" },
	keys = {
		{
			"<F7>",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle breakpoint",
		},
		{
			"<F8>",
			function()
				require("dap").continue()
			end,
			desc = "Continue debugging",
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "Step over",
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
			desc = "Step into",
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
			desc = "Step out",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.toggle()
			end,
			desc = "Toggle debug REPL",
		},
		{
			"<leader>dw",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Debug hover widget",
		},
	},
	config = function()
		local dap = require("dap")

		for _, adapter in ipairs({ "pwa-node" }) do
			dap.adapters[adapter] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
					args = { "${port}" },
				},
			}
		end

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
		vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "CursorLine" })

		for _, language in ipairs({ "typescript", "javascript" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					protocol = "inspector",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					sourceMaps = true,
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
					protocol = "inspector",
				},
				{
					name = "Remote Fortigate Node",
					type = "pwa-node",
					request = "attach",
					port = function()
						return vim.fn.input("Port: ")
					end,
					address = function()
						return vim.fn.input("Address: ")
					end,
					sourceMaps = true,
					protocol = "inspector",
					localRoot = "${workspaceFolder}",
					resolveSourceMapLocations = { "${workspaceFolder}/.build/node-scripts/", "!**/node_modules/**" },
					remoteRoot = "/node-scripts/",
					outDir = "${workspaceFolder}/.build/node-scripts",
					trace = "sm",
				},
			}
		end
	end,
}
