return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	config = function()
		require("lualine").setup({
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					"diff",
				},
				lualine_c = { "filename" },
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = "󱤅 ", other = "󰠠 " },
						diagnostics_color = {
							error = { fg = "#ff0000" },
							warn = { fg = "#ffa500" },
							info = { fg = "#0000ff" },
							hint = { fg = "#00ff00" },
						},
						colored = true,
						padding = 1,
					},
				},
				lualine_y = { "encoding", "fileformat", "filetype" },
				lualine_z = {
					{
						"location",
						icon = { "", align = "left", color = { fg = "#000000" } },
					},
					{
						"progress",
						icon = { "", align = "left", color = { fg = "#000000" } }
					},
				},
			},
			options = {
				theme = "monokai-pro",
				-- section_separators = { left = " ", right = " " },
				-- component_separators = { left = "", right = "" },
				globalstatus = true,
				-- disabled_filetypes = { "dashboard" },
			},
		})
	end,
}
