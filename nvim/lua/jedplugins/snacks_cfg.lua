local function git_diff_only(ctx)
	local cmd = { "git", "--no-pager", "show", "--format=", ctx.item.commit }
	local pathspec = ctx.item.files or ctx.item.file
	pathspec = type(pathspec) == "table" and pathspec or { pathspec }
	if #pathspec > 0 then
		cmd[#cmd + 1] = "--"
		vim.list_extend(cmd, pathspec)
	end
	require("snacks.picker.preview").cmd(cmd, ctx, { ft = "git" })
end

local dropdown = {
	layout = {
		backdrop = false,
		row = 5,
		width = 0.6,
		min_width = 80,
		height = 0.8,
		border = "none",
		box = "vertical",
		{
			box = "vertical",
			border = "rounded",
			title = "{title} {live} {flags}",
			title_pos = "center",
			{ win = "input", height = 1, border = "bottom" },
			{ win = "list", border = "none" },
		},
		{ win = "preview", title = "{preview}", height = 0.7, border = "rounded" },
	},
}

return {
	"folke/snacks.nvim",
	opts = {
		terminal = {
			win = {
				position = "float",
			},
		},
		picker = {
			win = {
				input = {
					keys = {
						["<C-F>"] = { "preview_scroll_up", mode = { "i", "n" } },
					},
				},
			},
		},
		explorer = {},
	},
	keys = {
		{ "<space>e",  function() Snacks.picker.explorer() end, desc = "Toggle Explorer" },
		{ "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },

		-- Files
		{ "<leader>ff", function() Snacks.picker.files({ layout = dropdown }) end, desc = "Files" },
		{ "<leader>fF", function() Snacks.picker.files({ layout = dropdown, hidden = true }) end, desc = "Files (hidden)" },
		{ "<leader>fe", function() Snacks.picker.files({ cwd = vim.fn.expand("%:h"), layout = dropdown }) end, desc = "Files in directory" },
		{ "<leader>fp", function() Snacks.picker.git_files({ layout = dropdown }) end, desc = "Git files" },
		{ "<leader>fh", function() Snacks.picker.git_diff({ layout = dropdown }) end, desc = "Git files" },

		-- Angular
		{
			"<leader>fa",
			function()
				Snacks.picker.files({
					args = { "-t", "f", "-e", "ts", "-e", "html", "-e", "scss", "-e", "css", "-E", "*.spec.ts" },
					layout = dropdown,
				})
			end,
			desc = "Angular files",
		},
		{
			"<leader>fu",
			function()
				Snacks.picker.files({
					args = { "-e=ts", "-t=f", ".*spec.ts$" },
					layout = dropdown,
				})
			end,
			desc = "Angular unit test files",
		},

		-- LSP
		{
			"<leader>ft",
			function()
				Snacks.picker.lsp_symbols({ layout = { preset = "sidebar", preview = "main" }, main = { current = true }, auto_close = false })
			end,
			desc = "LSP symbols",
		},
		{ "<leader>fr", function() Snacks.picker.lsp_references({ layout = dropdown }) end, desc = "LSP references" },

		-- Grep
		{ "<leader>fg", function() Snacks.picker.grep({ layout = dropdown }) end, desc = "Grep" },
		{ "<leader>fib", function() Snacks.picker.lines({ layout = { preset = "ivy", preview = "main" }, main = { current = true } }) end, desc = "Buffer lines" },
		{ "<leader>fw", function() Snacks.picker.grep_word({ layout = dropdown }) end, desc = "Visual selection or word", mode = { "n", "x" } },

		-- Buffers
		{ "<leader>fb", function() Snacks.picker.buffers({ layout = dropdown }) end, desc = "Buffers" },
		{ "<leader>fq", function() Snacks.picker.qflist({ layout = dropdown }) end, desc = "Quickfix list" },

		-- Git
		{ "<leader>gb", function() Snacks.picker.git_branches({ layout = dropdown }) end, desc = "Git branches" },
		{
			"<leader>glh",
			function()
				Snacks.picker.git_log_line({
					preview = git_diff_only,
					layout = {
						layout = {
							backdrop = false,
							width = 0.9,
							height = 0.9,
							border = "rounded",
							box = "horizontal",
							{
								box = "vertical",
								width = 0.4,
								border = "none",
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
							{ win = "preview", title = "{preview}", border = "left" },
						},
					},
				})
			end,
			desc = "Git log line",
		},
		{
			"<leader>gfh",
			function()
				Snacks.picker.git_log_file({
					preview = git_diff_only,
					layout = {
						layout = {
							backdrop = false,
							width = 0.9,
							height = 0.9,
							border = "rounded",
							box = "horizontal",
							{
								box = "vertical",
								width = 0.4,
								border = "none",
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
							{ win = "preview", title = "{preview}", border = "left" },
						},
					},
				})
			end,
			desc = "Git file history",
		},

		-- Diagnostics
		{ "<leader>fD", function() Snacks.picker.diagnostics({ layout = dropdown }) end, desc = "Diagnostics" },
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics_buffer({ layout = { preset = "ivy", preview = "main" }, main = { current = true } })
			end,
			desc = "Buffer Diagnostics",
		},

		-- Highlights
		{ "<leader>sH", function() Snacks.picker.highlights({ layout = dropdown }) end, desc = "Highlights" },
	},
}
