return {
	"softoika/ngswitcher.vim",
	config = function()
		local silentopts = { noremap = true, silent = true }

		vim.keymap.set("n", "<leader>ac", "<cmd> NgSwitchTS<CR>", silentopts)
		vim.keymap.set("n", "<leader>at", "<cmd> NgSwitchHTML<CR>", silentopts)
		vim.keymap.set("n", "<leader>as", "<cmd> NgSwitchCSS<CR>", silentopts)
		vim.keymap.set("n", "<leader>au", "<cmd> NgSwitchSpec<CR>", silentopts)
	end,
}
