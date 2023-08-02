function Config()
	local actions = require("telescope.actions")

	require("telescope").setup({
		defaults = {
			path_display = "truncate",
			file_ignore_patterns = { "node%_modules/.*" },
			sorting_strategy = "ascending",
			prompt_prefix = "  ",
			selection_caret = "󰄾 ",
			preview_title = "",
			mappings = {
				i = {
					["<C-k>"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
					["<C-[>"] = actions.close,
					["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
				},
			},
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.50,
				},
				vertical = {
					mirror = true,
					prompt_position = "top",
					width = 0.5,
					height = 0.5,
				},
				width = 0.7,
			},
		},
		extension = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "ignore_case",
			},
		},
	})

	require("telescope").load_extension("fzf")
	require("telescope").load_extension("dap")
	require("telescope").load_extension("live_grep_args")

	-- KEY BINDINGS
	local builtin = require("telescope.builtin")
	local extensions = require("telescope").extensions
	local silentopts = { noremap = true, silent = true }

	vim.keymap.set(
		"n",
		"<leader>fr",
		'<cmd> lua require("telescope.builtin").lsp_references({ show_line = false })<CR>',
		silentopts
	)
	vim.keymap.set("n", "<leader>fg", extensions.live_grep_args.live_grep_args, silentopts)
	vim.keymap.set(
		"n",
		"<leader>ff",
		'<cmd> lua require("telescope.builtin").find_files({ hidden = true, previewer = false, file_ignore_patterns = { "node_modules" } })<CR>',
		silentopts
	)
	vim.keymap.set(
		"n",
		"<leader>fw",
		'<cmd> lua require("telescope.builtin").find_files({ previewer = false, prompt_title = "Web Dev Files", file_ignore_patterns = { "node_modules"}, find_command = { "fd", "-t", "f", "-e", "ts", "-e", "html", "-e", "js", "-e", "scss", "-e", "css", "-e", "json" } })<CR>'
	)
	vim.keymap.set(
		"n",
		"<leader>fp",
		'<cmd> lua require("telescope.builtin").git_files({ previewer = false })<CR>',
		silentopts
	)
	vim.keymap.set(
		"n",
		"<leader>ft",
		'<cmd> lua require("telescope.builtin").lsp_document_symbols({ ignore_symbols = { "constant" } })<CR>',
		silentopts
	)
	vim.keymap.set(
		"n",
		"<leader>fb",
		'<cmd> lua require("telescope.builtin").buffers{ layout_strategy = "vertical", previewer = false }<CR>',
		silentopts
	)
	vim.keymap.set("n", "<leader>fs", builtin.grep_string, silentopts)
	vim.keymap.set("n", "<leader>d", builtin.diagnostics, silentopts)
end

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			{ "nvim-telescope/telescope-dap.nvim", dependencies = { "mfussenegger/nvim-dap" } },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = Config,
	},
}
