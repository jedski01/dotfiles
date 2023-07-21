return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" }, -- Required
		{ -- Optional
			"williamboman/mason.nvim",
			build = function()
				pcall(vim.cmd, "MasonUpdate")
			end,
		},
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" }, -- Required
		{ "hrsh7th/cmp-nvim-lsp" }, -- Required
		{ "L3MON4D3/LuaSnip" }, -- Required
		{ "saadparwaiz1/cmp_luasnip" },
		{ "rafamadriz/friendly-snippets" },
		{ "onsails/lspkind.nvim" },
		{ "jose-elias-alvarez/null-ls.nvim" },
	},
	config = function()
		local lspzero = require("lsp-zero")

		lspzero.preset("recommended")

		lspzero.ensure_installed({
			-- WEBDEV
			-- "tsserver",
			"angularls",
			"cssls",
			"html",
			-- "eslint",
			-- LUA
			"lua_ls",
			-- RUST
			"rust_analyzer",
			-- C/C++
			"clangd",
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
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			},
		})

		require("luasnip.loaders.from_vscode").lazy_load()

		local function organize_imports()
			local params = {
				command = "_typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(0) },
				title = "",
			}
			vim.lsp.buf.execute_command(params)
		end

		-- require("lspconfig").tsserver.setup({
		-- 	commands = {
		-- 		OrganizeImports = {
		-- 			organize_imports,
		-- 			description = "Organize imports",
		-- 		},
		-- 	},
		-- })

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
				["null-ls"] = { "javascript", "typescript", "lua", "html", "css", "scss", "json", "c" },
			},
		})
		lspzero.setup()

		-- Override capabilities for clangd to fix offset encoding warning
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.offsetEncoding = { "utf-16" }

		-- require("lspconfig").clangd.setup({ capabilities = capabilities })

		-- Setup cmp kind after lspzero
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				fields = { "menu", "abbr", "kind" },
				format = require("lspkind").cmp_format({
					mode = "symbol_text",
					maxwidth = 100,
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
				-- formatters
				null_ls.builtins.formatting.prettier_d_slim,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.clang_format,
			},
		})

		vim.diagnostic.config({
			virtual_text = false,
		})
		local ls = require("luasnip")
		local snip = ls.snippet
		local text = ls.text_node
		local insert = ls.insert_node
		local keymap = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		ls.add_snippets(nil, {
			typescript = {
				snip({
					trig = "it",
					name = "jasmine test case",
					dscr = "Create a new test case",
				}, {
					text({ "it('" }),
					insert(1),
					text({ "', () => {" }),
					text({ "", "\t" }),
					insert(2),
					text({ "", "});" }),
					insert(0),
				}),
				snip({
					trig = "ait",
					name = "jasmine fakeAsync test case",
					dscr = "Create a new test fakeAsync case",
				}, {
					text({ "it('" }),
					insert(1),
					text({ "', fakeAsync(() => {" }),
					text({ "", "\t" }),
					insert(2),
					text({ "", "}));" }),
					insert(0),
				}),
			},
		})

		keymap("i", "<c-j>", "<cmd> lua require'luasnip'.jump(1)<CR>", opts)
		keymap("i", "<c-k>", "<cmd> lua require'luasnip'.jump(-1)<CR>", opts)
	end,
}
