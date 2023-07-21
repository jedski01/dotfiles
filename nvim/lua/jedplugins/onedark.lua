return {
	"navarasu/onedark.nvim",
	config = function()
		local color = require("onedark.palette")

		require("onedark").setup({
			style = "warmer",
			term_colors = true,
			colors = {
				fg = "#e8e8e8",
				dark_purple = "#cf5fc4",
			},
			highlights = {
				IndentBlanklineContextChar = { fg = "$orange", gui = "nocombine" },
			},
			diagnostics = {
				undercurl = true,
			},
		})

		require("onedark").load()

		vim.cmd("colorscheme onedark")

		vim.api.nvim_set_hl(0, "FloatBorder", { bg = color.warm.bg0, fg = "#e8e8e8" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = color.warm.bg0 })

		vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = color.warm.diff_text, fg = "#e8e8e8" })
		vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = color.warm.bg2 })

		vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = color.warm.diff_text })
		vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = color.warm.diff_text, fg = color.warm.diff_text })
		vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = "#e8e8e8" })
		vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#e8e8e8" })

		vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = color.warm.bg0 })
		vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = color.warm.bg0, bg = color.warm.bg0 })
		vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = color.warm.bg0, bg = color.warm.bg0 })

		vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = color.warm.bg0 })
		vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = color.warm.bg0, fg = color.warm.bg0 })

		vim.api.nvim_set_hl(0, "CursorLine", { bg = color.warmer.bg0 })
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = color.warmer.orange })
		vim.api.nvim_set_hl(0, "FidgetTask", { bg = color.warm.bg0, fg = "#e8e8e8" })
		vim.api.nvim_set_hl(0, "FidgetTitle", { bg = color.warm.bg0, fg = color.warm.orange })
		vim.api.nvim_set_hl(0, "MarkSignHL", { fg = color.warmer.blue })

		vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = color.warmer.red, fg = color.warmer.red })
	end,
}
