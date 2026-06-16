return {
	"yioneko/nvim-vtsls",
	enabled = true,
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "typescript.tsx", "javascript.jsx" },
	dependencies = { "nvim-lspconfig" },
	config = function()
		vim.lsp.config('vtsls', {
			settings = {
				typescript = {
					tsserver = {
						maxTsServerMemory = 8192,
					},
					preferences = {
						quoteStyle = "auto",
						importModuleSpecifier = "project-relative",
						includeCompletionsWithSnippetText = false,
					},
					inlayHints = {
						parameterNames = { enabled = "literals" },
						functionLikeReturnTypes = { enabled = true },
					},
					updateImportsOnFileMove = { enabled = "always" },
				},
				javascript = {
					preferences = {
						quoteStyle = "auto",
						importModuleSpecifier = "project-relative",
					},
					updateImportsOnFileMove = { enabled = "always" },
				},
				vtsls = {
					enableMoveToFileCodeAction = false,
					experimental = {
						completion = { enableServerSideFuzzyMatch = true },
					},
				},
			},
			on_attach = function(client, bufnr)
				-- #4: if angularls is attached to this buffer, let it own semantic tokens
				local has_angular = vim.lsp.get_clients({ bufnr = bufnr, name = "angularls" })
				if #has_angular > 0 then
					pcall(vim.lsp.semantic_tokens.stop, bufnr, client.id)
				end

				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "<leader>toi", ":VtsExec organize_imports<CR>", vim.tbl_extend("force", opts, { desc = "Organize imports" }))
				vim.keymap.set("n", "<leader>tsi", ":VtsExec sort_imports<CR>", vim.tbl_extend("force", opts, { desc = "Sort imports" }))
				vim.keymap.set("n", "<leader>tru", ":VtsExec remove_unused_imports<CR>", vim.tbl_extend("force", opts, { desc = "Remove unused imports" }))
				vim.keymap.set("n", "<leader>tfa", ":VtsExec fix_all<CR>", vim.tbl_extend("force", opts, { desc = "Fix all" }))
				vim.keymap.set("n", "<leader>tmi", ":VtsExec add_missing_imports<CR>", vim.tbl_extend("force", opts, { desc = "Add missing imports" }))
				vim.keymap.set("n", "<leader>trf", ":VtsExec rename_file<CR>", vim.tbl_extend("force", opts, { desc = "Rename file" }))
				vim.keymap.set("n", "<leader>tfr", ":VtsExec file_references<CR>", vim.tbl_extend("force", opts, { desc = "File references" }))
				vim.keymap.set("n", "<leader>ts", ":VtsExec goto_source_definition<CR>", vim.tbl_extend("force", opts, { desc = "Go to source definition" }))
			end,
		})

		local opts = { noremap = true, silent = true }
		vim.keymap.set("n", "<leader>trs", ":VtsExec restart_tsserver<CR>", vim.tbl_extend("force", opts, { desc = "Restart tsserver" }))
		vim.keymap.set("n", "<leader>trc", ":VtsExec goto_project_config<CR>", vim.tbl_extend("force", opts, { desc = "Go to project config" }))
	end,
}
