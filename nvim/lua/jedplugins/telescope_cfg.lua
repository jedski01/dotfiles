function Config()
	local actions = require("telescope.actions")
	local trouble = require("trouble.sources.telescope")
	local telescope_actions = require("telescope.actions")

	local function send_to_quickfix(bufnr)
		telescope_actions.smart_send_to_qflist(bufnr)
		vim.cmd([[botright cwindow 40]])
	end

	local lga_actions = require("telescope-live-grep-args.actions")

	require("telescope").setup({
		defaults = {
			sort_mru = true,
			preview = {
				treesitter = false,
			},
			path_display = { "truncate" },
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
					["<C-a>"] = actions.cycle_previewers_next,
					["<C-s>"] = actions.cycle_previewers_prev,
					["<C-q>"] = send_to_quickfix,
					["<C-t>"] = trouble.open,
				},
				n = {
					["<C-q>"] = send_to_quickfix,
					["<C-t>"] = trouble.open_with_trouble,
				},
			},
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.45,
				},
				vertical = {
					mirror = true,
					prompt_position = "top",
					width = 0.5,
					height = 0.5,
				},
				width = 0.85,
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "ignore_case",
			},
			live_grep_args = {
				auto_quoting = true,
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--trim",
				},
				mappings = { -- extend mappings
					i = {
						["<C-o>"] = lga_actions.quote_prompt(),
						["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
						-- freeze the current list and start a fuzzy search in the frozen list
						["<C-space>"] = actions.to_fuzzy_refine,
					},
				},
			},
      ["ui-select"] = {
        require("telescope.themes").get_cursor{
          layout_config = {
            width = 0.4
          }
        }
      }
		},
	})

	require("telescope").load_extension("fzf")
	require("telescope").load_extension("dap")
  require("telescope").load_extension("ui-select")
	require("telescope").load_extension("bookmarks")
  require("telescope").load_extension("git_file_history")

	require("telescope").load_extension("live_grep_args")

	-- KEY BINDINGS
	local builtin = require("telescope.builtin")
	local extensions = require("telescope").extensions
	local lga_shortcuts = require("telescope-live-grep-args.shortcuts")
	local silentopts = { noremap = true, silent = true }

	vim.keymap.set(
		"n",
		"<leader>fr",
		'<cmd> lua require("telescope.builtin").lsp_references({ show_line = false })<CR>',
		silentopts
	)
	vim.keymap.set("n", "<leader>fg", extensions.live_grep_args.live_grep_args, silentopts)
	vim.keymap.set("n", "<leader>fd", lga_shortcuts.grep_word_under_cursor, silentopts)
	vim.keymap.set("v", "<leader>fd", lga_shortcuts.grep_visual_selection, silentopts)
	vim.keymap.set(
		"n",
		"<leader>ff",
		'<cmd> lua require("telescope.builtin").find_files({ hidden = true, previewer = false, file_ignore_patterns = { "node_modules" } })<CR>',
		silentopts
	)
	vim.keymap.set(
		"n",
		"<leader>fw",
		'<cmd> lua require("telescope.builtin").find_files({ previewer = false, prompt_title = "Web Dev Files", file_ignore_patterns = { "node_modules"}, find_command = { "fd", "-t", "f", "-e", "ts", "-e", "html", "-e", "js", "-e", "scss", "-e", "css", "-e", "json", "-E", "*.spec.ts" } })<CR>'
	)
	vim.keymap.set(
		"n",
		"<leader>fa",
		'<cmd> lua require("telescope.builtin").find_files({ previewer = false, prompt_title = "Angular Files", file_ignore_patterns = { "node_modules"}, find_command = { "fd", "-t", "f", "-e", "ts", "-e", "html", "-e", "scss", "-e", "css", "-E", "*.spec.ts" } })<CR>'
	)
	vim.keymap.set(
		"n",
		"<leader>fu",
		'<cmd> lua require("telescope.builtin").find_files({ previewer = false, prompt_title = "Angular Unit test files", file_ignore_patterns = { "node_modules"}, find_command = { "fd", "-t", "f", ".*spec.ts$" } })<CR>'
	)
	vim.keymap.set(
		"n",
		"<leader>fe",
		'<cmd> lua require("telescope.builtin").find_files({ previewer = false, prompt_title = "Search in Current Directory", file_ignore_patterns = { "node_modules" }, cwd = require("telescope.utils").buffer_dir() })<CR>'
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
		'<cmd> lua require("telescope.builtin").lsp_document_symbols({ ignore_symbols = { "constant" }, symbol_width=70 })<CR>',
		silentopts
	)
	vim.keymap.set(
		"n",
		"<leader>fb",
		'<cmd> lua require("telescope.builtin").buffers{ layout_strategy = "vertical", previewer = false, path_display = { "tail" }, show_all_buffers = false }<CR>',
		silentopts
	)
	vim.keymap.set(
		"n",
		"<leader>fiz",
		'<cmd> lua require("telescope.builtin").current_buffer_fuzzy_find{ previewer = false }<CR>',
		silentopts
	)
	vim.keymap.set(
		"n",
		"<leader>fib",
		'<cmd> lua require("telescope.builtin").current_buffer_fuzzy_find{ fuzzy = false }<CR>',
		silentopts
	)
	vim.keymap.set("n", "<leader>fs", builtin.grep_string, silentopts)
	vim.keymap.set("n", "<leader>d", builtin.diagnostics, silentopts)

	vim.keymap.set(
		"n",
		"<leader>glb",
		"<cmd> lua require('telescope.builtin').git_branches({ layout_strategy = 'vertical', pattern = 'refs/heads/', previewer = false })<CR>",
		silentopts
	)
	vim.keymap.set(
		"n",
		"<leader>gb",
		"<cmd> lua require('telescope.builtin').git_branches({ layout_strategy = 'vertical', previewer = false})<CR>",
		silentopts
	)
  vim.keymap.set(
    "n",
    "<leader>fh",
    "<cmd> lua require('telescope').extensions.git_file_history.git_file_history()<CR>"
  )

	vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, silentopts)
end

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
      "tomasky/bookmarks.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			{ "nvim-telescope/telescope-dap.nvim", dependencies = { "mfussenegger/nvim-dap" } },
      { "nvim-telescope/telescope-ui-select.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
      {
        "isak102/telescope-git-file-history.nvim",
        dependencies = { "tpope/vim-fugitive" }
      }
		},
		config = Config,
	},
}
