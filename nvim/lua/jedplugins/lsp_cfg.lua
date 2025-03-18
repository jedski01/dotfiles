return {
	{
		"VonHeikemen/lsp-zero.nvim",
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
			{ "hrsh7th/cmp-path" },
			{ "windwp/nvim-autopairs" },
			{ "ranjithshegde/ccls.nvim" },
		},
		config = function()
			-- Add cmp_nvim_lsp capabilities settings to lspconfig
			-- This should be executed before you configure any language server
			local lspconfig_defaults = require("lspconfig").util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- This is where you enable features that only work
			-- if there is a language server active in the file
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "gd", "<cmd> lua vim.lsp.buf.definition()<CR>", opts)
					vim.keymap.set("n", "gD", "<cmd> lua vim.lsp.buf.declaration()<CR>", opts)
					vim.keymap.set("n", "K", "<cmd> lua vim.lsp.buf.hover()<CR>", opts)
					vim.keymap.set("n", "[d", "<cmd> lua vim.diagnostic.goto_prev()<CR>", opts)
					vim.keymap.set("n", "]d", "<cmd> lua vim.diagnostic.goto_next()<CR>", opts)
					vim.keymap.set("n", "<leader>lr", "<cmd> lua vim.lsp.buf.rename()<CR>", opts)
					vim.keymap.set("n", "<space>s", "<cmd> lua vim.diagnostic.open_float()<CR>", opts)
					vim.keymap.set("n", "<leader>ca", "<cmd> lua vim.lsp.buf.code_action()<CR>", opts)
					vim.keymap.set("n", "<space>l", ":EslintFixAll<CR>", opts)
				end,
			})
			require("mason").setup({})
			local ensure_installed = { "rust_analyzer", "angularls", "html", "jsonls", "lua_ls", "bashls", "eslint" }
			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
			})

			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					-- { name = "nvim_lsp", max_item_count = 20, keyword_length = 2 },
					-- { name = "luasnip", max_item_count = 20, keyword_length = 2 },
					{ name = "path" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				enabled = function()
					local buftype = vim.api.nvim_buf_get_option(0, "buftype")
					if buftype == "prompt" then
						return false
					end

					local context = require("cmp.config.context")
					local buftype = vim.api.nvim_buf_get_option(0, "buftype")
					if
						context.in_treesitter_capture("comment") == true
						or context.in_syntax_group("Comment")
						-- or context.in_treesitter_capture("string")
						-- or context.in_treesitter_capture("string.regex")
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
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

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

			require("luasnip.loaders.from_vscode").lazy_load()
			require("ccls").setup({ lsp = { use_defaults = true } })

			-- load languages
			for i, v in ipairs(ensure_installed) do
				require("lspconfig")[v].setup({})
			end

			-- Additional settings
			vim.api.nvim_set_keymap("n", "<space>e", ":EslintFixAll<CR>", { noremap = true, silent = true })
			vim.diagnostic.config({
				virtual_text = false,
			})
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end,
	},
}
