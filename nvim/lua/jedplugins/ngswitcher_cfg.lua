return {
	"softoika/ngswitcher.vim",
	config = function()
		local silentopts = { noremap = true, silent = true }

		vim.keymap.set("n", "<leader>ac", "<cmd> NgSwitchTS<CR>", silentopts)
		vim.keymap.set("n", "<leader>at", "<cmd> NgSwitchHTML<CR>", silentopts)
		vim.keymap.set("n", "<leader>as", "<cmd> NgSwitchCSS<CR>", silentopts)
		vim.keymap.set("n", "<leader>au", "<cmd> NgSwitchSpec<CR>", silentopts)

		vim.keymap.set("n", "<leader>vac", "<cmd> VNgSwitchTS<CR>", silentopts)
		vim.keymap.set("n", "<leader>vat", "<cmd> VNgSwitchHTML<CR>", silentopts)
		vim.keymap.set("n", "<leader>vas", "<cmd> VNgSwitchCSS<CR>", silentopts)
		vim.keymap.set("n", "<leader>vau", "<cmd> VNgSwitchSpec<CR>", silentopts)

		vim.keymap.set("n", "<leader>hac", "<cmd> SNgSwitchTS<CR>", silentopts)
		vim.keymap.set("n", "<leader>hat", "<cmd> SNgSwitchHTML<CR>", silentopts)
		vim.keymap.set("n", "<leader>has", "<cmd> SNgSwitchCSS<CR>", silentopts)
		vim.keymap.set("n", "<leader>hau", "<cmd> SNgSwitchSpec<CR>", silentopts)
	end,
}
