return {
	"nvim-tree/nvim-tree.lua",
  name = "nvimtree",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional
	},
	lazy = false,
	priority = 99,
	config = function()
		local icons = {
			git_placement = "after",
			modified_placement = "after",
			padding = " ",
			glyphs = {
				default = "󰈔",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = " ",
					open = " ",
					empty = " ",
					empty_open = " ",
					symlink = "󰉒 ",
					symlink_open = "󰉒 ",
				},
				git = {
					deleted = "",
					unstaged = "",
					untracked = "",
					staged = "",
					unmerged = "",
					ignored = "I",
					renamed = "R",
				},
			},
		}

		local renderer = {
      root_folder_label = function(path)
          return "󰉒 " .. vim.fn.fnamemodify(path, ":t")
      end,
			indent_width = 2,
			indent_markers = {
				enable = true,
				inline_arrows = true,
				icons = { corner = "╰" },
			},
			icons = icons,
		}
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
			renderer = renderer,
		})

		vim.api.nvim_set_keymap("n", "<leader>tt", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>tf", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>mn", require("nvim-tree.api").marks.navigate.next)
		vim.keymap.set("n", "<leader>mp", require("nvim-tree.api").marks.navigate.prev)
		vim.keymap.set("n", "<leader>ms", require("nvim-tree.api").marks.navigate.select)
	end,
}
