return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional
	},
  lazy = false,
  priority = 99,
	config = function()
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
					close = true,
				},
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
		vim.keymap.set("n", "<leader>mn", require("nvim-tree.api").marks.navigate.next)
		vim.keymap.set("n", "<leader>mp", require("nvim-tree.api").marks.navigate.prev)
		vim.keymap.set("n", "<leader>ms", require("nvim-tree.api").marks.navigate.select)
	end,
}
