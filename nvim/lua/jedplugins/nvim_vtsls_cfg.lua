return	{
		"yioneko/nvim-vtsls",
    enabled = false,
		ft = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
		dependencies = { "nvim-lspconfig" },

		config = function()
			require("lspconfig").vtsls.setup({
				on_attach = function(client, bufnr)
					local opts = { noremap = true, silent = true }
					local buf_keymap = vim.api.nvim_buf_set_keymap
					buf_keymap(bufnr, "n", "<leader>toi", ":VtsExec organize_imports<CR>", opts)
					buf_keymap(bufnr, "n", "<leader>tsi", ":VtsExec sort_imports<CR>", opts)
					buf_keymap(bufnr, "n", "<leader>tru", ":VtsExec remove_unused<CR>", opts)
					buf_keymap(bufnr, "n", "<leader>tfa", ":VtsExec fix_all<CR>", opts)
					buf_keymap(bufnr, "n", "<leader>tmi", ":VtsExec add_missing_imports<CR>", opts)
				end,
			})

			local silentopts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap("n", "<leader>trs", ":VtsExec restart_tsserver<CR>", silentopts)
			vim.api.nvim_set_keymap("n", "<leader>trc", ":VtsExec goto_project_config<CR>", silentopts)
		end,
	}
