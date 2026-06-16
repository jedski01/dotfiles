return {
	"mbbill/undotree",
	cmd = "UndotreeToggle",
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
	},
	init = function()
		vim.g.undotree_WindowLayout = 4
		vim.g.undotree_DiffpanelHeight = 20
		vim.g.undotree_SplitWidth = 50
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
}
