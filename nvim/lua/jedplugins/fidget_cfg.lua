return {
	"j-hui/fidget.nvim",
  enabled = false,
	config = function()
		require("fidget").setup({
			window = {
				blend = 0,
			},
		})
	end,
}
