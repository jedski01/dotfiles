return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
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
