return {
	"AlexvZyl/nordic.nvim",
	lazy = false,
	priority = 1000,
	enabled = false,
	config = function()
		local colors = require("nordic.colors")

		require("nordic").load({
			cursorline = {
				theme = "light",
			},
			override = {
				-- IndentBlanklineContextChar = { fg = colors.orange.base },
				LspSignatureActiveParameter = { fg = colors.bg_float, sp = colors.white0 },
				Visual = { bg = colors.gray4 },
				BufferLineFill = { bg = colors.black0 },
				BufferLineTabSelected = { bg = colors.gray0, fg = colors.yellow.base },
			},
		})
	end,
}
