return {
	"Shatur/neovim-ayu",
	lazy = false,
	priority = 1000,
	config = function()
		local colors = require("ayu.colors")
		colors.generate() -- Pass `true` to enable mirage

		require("ayu").setup({
			overrides = {
				NvimTreeVertSplit = { fg = colors.panel_border },
        Visual = { bg = colors.ui },
        IncSearch = { bg = colors.ui, underline = true }
			},
		})
		vim.cmd("colorscheme ayu-mirage")
	end,
}
