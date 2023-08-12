return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				-- theme = "onedark",
        theme = "catppuccin-mocha",
				section_separators = "",
				component_separators = "",
				globalstatus = true,
				disabled_filetypes = { "packer", "dashboard", "NvimTree" },
			},
		})
	end,
}
