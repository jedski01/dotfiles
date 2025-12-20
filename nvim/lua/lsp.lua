-- vim.lsp.enable("ts_ls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("angularls")
vim.lsp.enable("html")
vim.lsp.enable("jsonls")
vim.lsp.enable("eslint")
vim.lsp.enable("clangd")
vim.lsp.enable("cssls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("gopls")

-- typescript custom commands
--
-- local function organize_ts_imports()
-- 	local params = {
-- 		command = "_typescript.organizeImports",
-- 		arguments = { vim.api.nvim_buf_get_name(0) },
-- 		title = "Orgnize TS Imports",
-- 	}
-- 	vim.lsp.buf.execute_command(params)
-- end
--
-- local function add_missing_imports()
-- 	vim.lsp.buf.code_action({ context = { only = { "source.addMissingImports.ts" } }, apply = true })
-- end
--
-- local function remove_unused_imports()
-- 	vim.lsp.buf.code_action({ context = { only = { "source.removeUnused.ts" } }, apply = true })
-- end
--
-- vim.api.nvim_create_user_command("OrganizeTSImports", organize_ts_imports, { desc = "Organize TS Imports" })
-- vim.api.nvim_create_user_command("AddMissingTSImports", add_missing_imports, { desc = "Add Missing TS Imports" })
-- vim.api.nvim_create_user_command("RemoveUnusedTSImports", remove_unused_imports, { desc = "Remove Unused TS Imports" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "gd", "<cmd> lua vim.lsp.buf.definition()<CR>", opts)
		vim.keymap.set("n", "gD", "<cmd> lua vim.lsp.buf.declaration()<CR>", opts)
		vim.keymap.set(
			"n",
			"K",
			"<cmd> lua vim.lsp.buf.hover({ border = { '╔', '═' ,'╗', '║', '╝', '═', '╚', '║' }})<CR>",
			opts
		)
		vim.keymap.set("n", "[d", "<cmd> lua vim.diagnostic.goto_prev()<CR>", opts)
		vim.keymap.set("n", "]d", "<cmd> lua vim.diagnostic.goto_next()<CR>", opts)
		vim.keymap.set("n", "<leader>lr", "<cmd> lua vim.lsp.buf.rename()<CR>", opts)
		vim.keymap.set(
			"n",
			"<space>s",
			"<cmd> lua vim.diagnostic.open_float({ border = { '╔', '═' ,'╗', '║', '╝', '═', '╚', '║' }})<CR>",
			opts
		)
		vim.keymap.set("n", "<leader>ca", "<cmd> lua vim.lsp.buf.code_action()<CR>", opts)
		vim.keymap.set("n", "<space>l", ":LspEslintFixAll<CR>", opts)
		-- typescript specific commands
		-- vim.keymap.set("n", "<leader>toi", ":OrganizeTSImports<CR>", opts)
		-- vim.keymap.set("n", "<leader>tmi", ":AddMissingTSImports<CR>", opts)
		-- vim.keymap.set("n", "<leader>tru", ":RemoveUnusedTSImports<CR>", opts)
	end,
})
