return {
	"akinsho/bufferline.nvim",
  after = "catppuccin",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
      highlights = require("catppuccin.groups.integrations.bufferline").get(),
			options = {
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "NvimTree",
						text = "Files",
						separator = true,
					},
				},
				show_close_icon = false,
				show_buffer_close_icons = false,
			},
		})

		vim.cmd([[highlight! link BufferLineOffsetSeparator NvimTreeVertSplit]])
	end,
}
