return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	keys = {
		{
			"<leader>ps",
			function()
				require("persistence").load()
			end,
			desc = "Restore session (cwd)",
		},
		{
			"<leader>pl",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore last session",
		},
	},
}
