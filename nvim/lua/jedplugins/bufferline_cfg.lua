return {
	"akinsho/bufferline.nvim",
	-- after = "catppuccin",
	dependencies = "nvim-tree/nvim-web-devicons",
  -- enabled = false,
	version = "*",
	event = "VeryLazy",
	config = function()
		require("bufferline").setup({
			-- highlights = require("catppuccin.groups.integrations.bufferline").get(),
			options = {
				diagnostics = "nvim_lsp",
				show_close_icon = false,
				show_buffer_close_icons = false,
				indicator = { style = "underline" },
			},
		})
	end,
}
