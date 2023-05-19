local lspzero = require("lsp-zero")

lspzero.preset("recommended")

lspzero.ensure_installed({
	"tsserver",
	"lua_ls",
	"rust_analyzer",
	"angularls",
	"cssls",
	"html",
	"eslint",
	-- DAP
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lspzero.defaults.cmp_mappings({
	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lspzero.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lspzero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false, silent = true }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
end)

lspzero.format_mapping("<Space>f", {
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		["null-ls"] = { "javascript", "typescript", "lua", "html", "css", "scss", "json" },
	},
})
lspzero.setup()

-- Setup cmp kind after lspzero
cmp.setup({
	confirmation = {
		completeopt = { "menu,menuone,noinsert" },
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			ellipsis_char = "...",
			menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[Latex]",
			},
		}),
	},
})

local null_ls = require("null-ls")
local null_opts = lspzero.build_options("null-ls", {})

null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)
	end,
	sources = {
		null_ls.builtins.formatting.prettier_d_slim,
		null_ls.builtins.formatting.stylua,
	},
})

vim.diagnostic.config({
	virtual_text = false,
})
