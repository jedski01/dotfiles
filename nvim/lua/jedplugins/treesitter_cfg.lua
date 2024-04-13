return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/nvim-treesitter-textobjects",
			-- "nvim-treesitter/nvim-treesitter-context",
		},
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "lua", "javascript", "typescript", "html", "scss", "rust", "json" },
				sync_install = true,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
          disable = { "c" }
				},
				indent = {
					enable = true,
					disable = { "c", "json" },
				},
				autotag = {
					enable = true,
					filetypes = { "html", "xml" },
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						scope_incremental = "<CR>",
						node_incremental = "<TAB>",
						node_decremental = "<S-TAB>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["aC"] = "@class.outer",
							["iC"] = "@class.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["ic"] = "@conditional.inner",
							["ac"] = "@conditional.outer",
							["ir"] = "@regex.inner",
							["ar"] = "@regex.outer",
						},
					},
				},
			})
			require("nvim-treesitter").setup()
			-- require("treesitter-context").setup()
		end,
	},
}
