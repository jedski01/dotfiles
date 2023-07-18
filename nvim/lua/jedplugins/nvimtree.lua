vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 50,
	},
	update_focused_file = {
		enable = true,
	},
  tab = {
    sync = {
      open = true,
      close = true
    }
  },
	renderer = {
		icons = {
			glyphs = {
				git = {
					unstaged = "",
					staged = "",
					unmerged = "⊜",
					renamed = "R",
					untracked = "",
					deleted = "D",
					ignored = "I",
				},
			},
			git_placement = "after",
			modified_placement = "after",
		},
	},
})

vim.api.nvim_set_keymap("n", "<leader>tt", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tf", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
