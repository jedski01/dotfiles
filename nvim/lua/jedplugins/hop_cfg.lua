return {
	"phaazon/hop.nvim",
	branch = "v2",
	config = function()
		local hop = require("hop")

		hop.setup()
		local silentopts = { noremap = true, silent = true }

		vim.api.nvim_set_keymap("n", "<leader>we", '<cmd>lua require("hop").hint_words()<CR>', silentopts)

		vim.api.nvim_set_keymap(
			"n",
			"<leader>ww",
			'<cmd>lua require("hop").hint_words({ current_line_only = true})<CR>',
			silentopts
		)

		vim.api.nvim_set_keymap("n", "<leader>wr", '<cmd>lua require("hop").hint_lines()<CR>', silentopts)
	end,
}
