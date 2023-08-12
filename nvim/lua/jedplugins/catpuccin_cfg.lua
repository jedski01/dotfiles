return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			flavour = "frappe",
			integrations = {
				fidget = true,
				hop = true,
				mason = true,
				notify = true,
				gitgutter = true,
        vimwiki = true,
			},
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
