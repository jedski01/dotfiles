return {
	"AlexvZyl/nordic.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local palette = require("nordic.colors")
		local colors = require("nordic.colors")

		require("nordic").load({
			cursorline = {
				theme = "light",
			},
			override = {
				IndentBlanklineContextChar = { fg = palette.orange.base },
				LspSignatureActiveParameter = { fg =  colors.bg_float, sp = colors.white0},
        Visual = { bg = palette.gray4 },
        BufferLineFill = { bg = palette.black0 },
        BufferLineTabSelected = { bg = palette.gray0, fg = palette.yellow.base }
			},
		})
	end,
}
