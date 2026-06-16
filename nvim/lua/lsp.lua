-- Apply blink.cmp capabilities to all LSP servers
vim.lsp.config('*', {
	capabilities = require('blink.cmp').get_lsp_capabilities(),
})

-- Override angularls config (vim.lsp.config() has higher priority than lsp/*.lua files)
vim.lsp.config('angularls', {
	filetypes = { 'typescript', 'html', 'htmlangular', 'typescriptreact', 'typescript.tsx' },
	root_markers = { 'angular.json', 'nx.json' },
})

vim.lsp.config('clangd', {
	cmd = { 'clangd', '--log=error' },
})

-- Enable LSP servers
vim.lsp.enable("lua_ls")
vim.lsp.enable("angularls")
vim.lsp.enable("html")
vim.lsp.enable("jsonls")
vim.lsp.enable("eslint")
vim.lsp.enable("clangd")
vim.lsp.enable("cssls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("gopls")
vim.lsp.enable("vtsls")

-- Monokai Pro themed float highlights for hover/diagnostics
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#2d2a2e", fg = "#c1c0c0" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#2d2a2e", fg = "#ab9df2" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#2d2a2e", fg = "#ff6188", bold = true })

local hover_opts = {
	max_width = 80,
	max_height = 20,
	wrap = true,
	title = " 󰋽 Docs ",
	title_pos = "center",
	focusable = true,
	close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
}

local diag_opts = {
	max_width = 80,
	wrap = true,
	title = " 󰀪 Diagnostics ",
	title_pos = "center",
	source = "if_many",
	header = "",
	prefix = " ",
}

vim.diagnostic.config({
	severity_sort = true,
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "\u{f057}",
			[vim.diagnostic.severity.WARN] = "\u{f071}",
			[vim.diagnostic.severity.INFO] = "\u{f05a}",
			[vim.diagnostic.severity.HINT] = "\u{f0eb}",
		},
	},
	float = diag_opts,
})

-- LSP attach keybindings
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		vim.keymap.set("n", "gD", function()
			vim.lsp.buf.declaration()
		end, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover(hover_opts)
		end, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({
				count = -vim.v.count1,
				on_jump = function(_, bufnr)
					vim.diagnostic.open_float(vim.tbl_extend("keep", diag_opts, { bufnr = bufnr, scope = "cursor", focus = false }))
				end,
			})
		end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({
				count = vim.v.count1,
				on_jump = function(_, bufnr)
					vim.diagnostic.open_float(vim.tbl_extend("keep", diag_opts, { bufnr = bufnr, scope = "cursor", focus = false }))
				end,
			})
		end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
		vim.keymap.set("n", "<leader>lr", function()
			vim.lsp.buf.rename()
		end, vim.tbl_extend("force", opts, { desc = "LSP rename" }))
		vim.keymap.set("n", "<space>s", function()
			vim.diagnostic.open_float(diag_opts)
		end, vim.tbl_extend("force", opts, { desc = "Show line diagnostics" }))
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, vim.tbl_extend("force", opts, { desc = "Code action" }))
		vim.keymap.set("n", "<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
		end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.name == "eslint" then
			vim.keymap.set("n", "<space>el", ":LspEslintFixAll<CR>", vim.tbl_extend("force", opts, { desc = "ESLint fix all" }))
		end
	end,
})
