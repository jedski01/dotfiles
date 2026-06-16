return {
	"softoika/ngswitcher.vim",
	keys = {
		{ "<leader>ac", "<cmd>NgSwitchTS<CR>", silent = true, desc = "Switch to component TS" },
		{ "<leader>at", "<cmd>NgSwitchHTML<CR>", silent = true, desc = "Switch to template HTML" },
		{ "<leader>as", "<cmd>NgSwitchCSS<CR>", silent = true, desc = "Switch to stylesheet" },
		{ "<leader>au", "<cmd>NgSwitchSpec<CR>", silent = true, desc = "Switch to spec file" },

		{ "<leader>vac", "<cmd>VNgSwitchTS<CR>", silent = true, desc = "Switch to component TS (vsplit)" },
		{ "<leader>vat", "<cmd>VNgSwitchHTML<CR>", silent = true, desc = "Switch to template HTML (vsplit)" },
		{ "<leader>vas", "<cmd>VNgSwitchCSS<CR>", silent = true, desc = "Switch to stylesheet (vsplit)" },
		{ "<leader>vau", "<cmd>VNgSwitchSpec<CR>", silent = true, desc = "Switch to spec file (vsplit)" },

		{ "<leader>hac", "<cmd>SNgSwitchTS<CR>", silent = true, desc = "Switch to component TS (split)" },
		{ "<leader>hat", "<cmd>SNgSwitchHTML<CR>", silent = true, desc = "Switch to template HTML (split)" },
		{ "<leader>has", "<cmd>SNgSwitchCSS<CR>", silent = true, desc = "Switch to stylesheet (split)" },
		{ "<leader>hau", "<cmd>SNgSwitchSpec<CR>", silent = true, desc = "Switch to spec file (split)" },
	},
}
