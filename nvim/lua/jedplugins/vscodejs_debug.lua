return {
	"mxsdev/nvim-dap-vscode-js",
	dependencies = {
		{
			"mfussenegger/nvim-dap",
			dependencies = "nvim-neotest/nvim-nio",
		},
		{
			"microsoft/vscode-js-debug",
			lazy = true,
			build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		},
	},
	config = function()
		local dap = require("dap")

		require("dap-vscode-js").setup({
			debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
			adapters = {
				"pwa-node",
				"pwa-chrome",
				"node-terminal",
			},
		})

		dap.set_log_level("TRACE")

		for _, language in ipairs({ "typescript", "javascript" }) do
			dap.configurations[language] = {
				-- debug single nodejs files
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					protocol = "inspector",
				},
				-- debug nodejs proceses (make sure to add --inspect when you run the process)
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					sourceMaps = true,
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
					protocol = "inspector",
				},
				-- Same as above, but this is for remote debugging
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
					-- outFiles = {
					--   "${workspaceFolder}/.build/node-scripts/*.js"
					-- }
				},
			}
		end
	end,
}
