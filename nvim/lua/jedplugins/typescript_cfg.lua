return {
	"jose-elias-alvarez/typescript.nvim",
	config = function()
		require("typescript").setup({
			disable_commands = false,
			go_to_source_definition = {
				fallback = true,
			},
			server = {
				on_attach = function(client, bufnr)
					local opts = { noremap = true, silent = true }
					local buf_keymap = vim.api.nvim_buf_set_keymap
					buf_keymap(bufnr, "n", "<leader>toi", ":TypescriptOrganizeImports<CR>", opts)
					buf_keymap(bufnr, "n", "<leader>tru", ":TypescriptRemoveUnused<CR>", opts)
					buf_keymap(bufnr, "n", "<leader>tfa", ":TypescriptFixAll<CR>", opts)
					buf_keymap(bufnr, "n", "<leader>tmi", ":TypescriptAddMissingImports<CR>", opts)
				end,
			},
		})
	end,
}
