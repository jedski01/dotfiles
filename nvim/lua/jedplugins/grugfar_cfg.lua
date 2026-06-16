return {
	"MagicDuck/grug-far.nvim",
	cmd = "GrugFar",
	opts = {},
	keys = {
		{
			"<leader>S",
			function()
				require("grug-far").open()
			end,
			desc = "Search & replace (GrugFar)",
		},
		{
			"<leader>sw",
			function()
				require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
			end,
			desc = "Search & replace word",
		},
		{
			"<leader>sw",
			function()
				require("grug-far").with_visual_selection()
			end,
			mode = "v",
			desc = "Search & replace selection",
		},
	},
}
