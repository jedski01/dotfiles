return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		require("typescript-tools").setup({
			on_attach = function(client, bufnr)
				local opts = { noremap = true, silent = true }

				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>toi", ":TSToolsOrganizeImports<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>tsi", ":TSToolsSortImports<CR>", opts)
				-- Removing unused imports is already done by organize, but add in just in case
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>tui", ":TSToolsRemoveUnusedImports<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>tru", ":TSToolsRemoveUnused<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>tfa", ":TSToolsFixAll<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>tgd", ":TSToolsGoToSourceDefinition<CR>", opts)
			end,
		})
	end,
}
