return {
	"chentoast/marks.nvim",
	config = function()
		require("marks").setup({
			default_mappings = true,
			force_write_shada = false,
			refresh_interval = 200,
		})
	end,
}
