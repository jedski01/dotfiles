return {
	"Shatur/neovim-ayu",
	lazy = false,
	priority = 1000,
	-- enabled = false,
	config = function()
		local colors = require("ayu.colors")
		colors.generate() -- Pass `true` to enable mirage

		require("ayu").setup({
			overrides = {
				NvimTreeVertSplit = { fg = colors.panel_border },
				Visual = { bg = colors.ui },
				IncSearch = { bg = colors.ui, underline = true },
				WinSeparator = { fg = colors.keyword },
				LineNr = { fg = colors.comment },
				SnacksPickerDir = { fg = "#979382" },
        SnacksPickerBufFlags = { fg = colors.accent }
			},
		})
		vim.cmd("colorscheme ayu-mirage")
    vim.api.nvim_set_hl(0, "NonText", { fg = "#636363", bg = "NONE" })
	end,
}
