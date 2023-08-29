return {
	{
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
			{ "hrsh7th/cmp-path" },
			{ "windwp/nvim-autopairs" },
		},
		config = function()
			local lspzero = require("lsp-zero")

			lspzero.preset("recommended")

			lspzero.ensure_installed({
				-- WEBDEV
				-- "tsserver",
				"vtsls",
				"angularls",
				"cssls",
				"html",
				"jsonls",
				-- "eslint",
				-- LUA
				"lua_ls",
				-- RUST
				"rust_analyzer",
				-- C/C++
				"clangd",
				-- Bash
				"bashls",
			})

			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local cmp_mappings = lspzero.defaults.cmp_mappings({
				["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			})
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			lspzero.setup_nvim_cmp({
				mapping = cmp_mappings,
				sources = {
					{ name = "nvim_lsp", max_item_count = 20, keyword_length = 2 },
					{ name = "luasnip", max_item_count = 20, keyword_length = 2 },
					{ name = "path", max_item_count = 20 },
				},
			})
			require("luasnip.loaders.from_vscode").lazy_load()

			lspzero.on_attach(function(client, bufnr)
				local opts = { noremap = true, silent = true }

				vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd> lua vim.lsp.buf.definition()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd> lua vim.lsp.buf.declaration()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd> lua vim.lsp.buf.hover()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd> lua vim.diagnostic.goto_prev()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd> lua vim.diagnostic.goto_next()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", "<cmd> lua vim.lsp.buf.rename()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>e", "<cmd> lua vim.diagnostic.open_float()<CR>", opts)
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

			require("lspconfig").clangd.setup({
				on_init = function(client)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})

			lspzero.setup()

			-- Override capabilities for clangd to fix offset encoding warning
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.offsetEncoding = { "utf-16" }

			-- Setup cmp kind after lspzero
			cmp.setup({
				enabled = function()
					local context = require("cmp.config.context")
					local buftype = vim.api.nvim_buf_get_option(0, "buftype")
					if
						context.in_treesitter_capture("comment") == true
						or context.in_syntax_group("Comment")
						or context.in_treesitter_capture("string")
						or context.in_treesitter_capture("string.regex")
						or buftype == "prompt"
					then
						return false
					end
					return true
				end,
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
					sorting = {
						comparators = {
							cmp.config.compare.offset,
							cmp.config.compare.exact,
							cmp.config.compare.score,
							cmp.config.compare.kind,
							cmp.config.compare.length,
							cmp.config.compare.order,
						},
					},
				},
				matching = {
					disallow_fuzzy_matching = true,
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
					null_ls.builtins.formatting.eslint_d,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.code_actions.eslint_d,
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
	},
	{
		"yioneko/nvim-vtsls",
		ft = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
		dependencies = { "nvim-lspconfig" },
		config = function()
			require("lspconfig").vtsls.setup({
				-- Add preferences here if needed
				-- check tabbing perhaps
				-- init_options = {
				--   preferences = {}
				-- }
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
		end,
	},
}
