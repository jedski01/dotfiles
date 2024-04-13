return {
	"tpope/vim-fugitive",
	config = function()
		local silentopts = { noremap = true, silent = true }

		vim.api.nvim_set_keymap("n", "<leader>gfh", ":G log --follow -p -20 -- %<CR>", silentopts)
		vim.api.nvim_set_keymap("n", "<leader>gs", ":0G<CR>", silentopts)
	end,
}
