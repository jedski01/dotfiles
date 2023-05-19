require("hop").setup()
local silentopts = { noremap = true, silent = true }

vim.api.nvim_set_keymap(
	"n",
	"<leader>w",
	'<cmd>lua require"hop".hint_words({ direction = require"hop.hint".HintDirection.AFTER_CURSOR})<CR>',
	silentopts
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>b",
	'<cmd>lua require"hop".hint_words({ direction = require"hop.hint".HintDirection.BEFORE_CURSOR})<CR>',
	silentopts
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>l",
	'<cmd>lua require"hop".hint_words({ direction = require"hop.hint".HintDirection.AFTER_CURSOR, current_line_only = true})<CR>',
	silentopts
)
vim.api.nvim_set_keymap("n", "<leader>h", ":HopPattern<CR>", silentopts)
