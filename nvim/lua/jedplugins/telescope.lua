local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules" },
		sorting_strategy = "ascending",
		prompt_prefix = "  ",
		selection_caret = "󰄾 ",
		results_title = "",
		preview_title = "",
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-[>"] = actions.close,
			},
		},
		layout_config = {
			horizontal = {
				prompt_position = "top",
			},
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

-- KEY BINDINGS
local builtin = require("telescope.builtin")
local silentopts = { noremap = true, silent = true }

vim.keymap.set(
	"n",
	"<leader>fr",
	'<cmd> lua require("telescope.builtin").lsp_references({ show_line = false })<CR>',
	silentopts
)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, silentopts)
vim.keymap.set(
	"n",
	"<leader>ff",
	'<cmd> lua require("telescope.builtin").find_files({ file_ignore_patterns = { "node_modules" } })<CR>',
	silentopts
)
vim.keymap.set(
	"n",
	"<leader>fw",
	'<cmd> lua require("telescope.builtin").find_files({ file_ignore_patterns = { "node_modules"}, find_command = { "fd", "-t", "f", "-e", "ts", "-e", "html", "-e", "js", "-e", "scss", "-e", "css"  } })<CR>'
)
vim.keymap.set("n", "<leader>fp", builtin.git_files, silentopts)
vim.keymap.set(
	"n",
	"<leader>fb",
	'<cmd> lua require("telescope.builtin").buffers{ layout_strategy = "center" }<CR>',
	silentopts
)
vim.keymap.set("n", "<leader>fs", builtin.grep_string, silentopts)
vim.keymap.set("n", "<leader>d", builtin.diagnostics, silentopts)
