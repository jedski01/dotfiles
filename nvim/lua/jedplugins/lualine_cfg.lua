return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- Required to properly set the colors.
		local c = require("nordic.colors")

		require("lualine").setup({
			sections = {
				lualine_a = {
					{
						"mode",
						separator = { right = " ", left = "" },
					},
				},
				lualine_b = {
					"branch",
					{
						"diff",
						padding = 0,
						color = { fg = c.gray3 },
						icon = { " ", color = { fg = c.gray3 } },
						symbols = { added = " ", modified = " ", removed = " " },
						diff_color = {
							added = { fg = c.gray4 },
							modified = { fg = c.gray4 },
							removed = { fg = c.gray4 },
						},
					},
				},
				lualine_c = {
					"filename",
					{
						"diagnostics",
						sources = { "nvim_lsp", "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = "󱤅 ", other = "󰠠 " },
						diagnostics_color = {
							error = { fg = c.error },
							warn = { fg = c.warn },
							info = { fg = c.info },
							hint = { fg = c.hint },
						},
						colored = true,
						padding = 1,
					},
				},
				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_workspace_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = "󱤅 ", other = "󰠠 " },
						diagnostics_color = {
							error = { fg = c.error },
							warn = { fg = c.warn },
							info = { fg = c.info },
							hint = { fg = c.hint },
						},
						colored = true,
						padding = 1,
					},
				},
				lualine_y = { "encoding", "fileformat", "filetype" },
				lualine_z = {
					{
						"location",
						icon = { "", align = "left", color = { fg = c.black } },
					},
					{
						"progress",
						icon = { "", align = "left", color = { fg = c.black } },
						separator = { right = "", left = "" },
					},
				},
			},
			options = {
				-- theme = "onedark",
				-- theme = "catppuccin-mocha",
				theme = "nordic",
				section_separators = { left = " ", right = " " },
				component_separators = { left = "", right = "" },
				globalstatus = true,
				disabled_filetypes = { "packer", "dashboard", "NvimTree" },
			},
		})
	end,
}
