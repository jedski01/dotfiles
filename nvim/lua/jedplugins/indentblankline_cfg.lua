return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		local colors = require("ayu.colors")
		local hooks = require("ibl.hooks")
		local highlight = { "IndentBlanklineContextChar" }

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = colors.keyword })
		end)

		require("ibl").setup({
			exclude = {
				filetypes = { "NvimTree", "startify", "dashboard", "help", "markdown" },
			},
			scope = {
				highlight = highlight,
			},
		})
	end,
}
