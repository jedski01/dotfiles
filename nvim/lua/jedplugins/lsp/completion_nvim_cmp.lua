return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip", -- Required for cmp-luasnip
		"saadparwaiz1/cmp_luasnip",
    "windwp/nvim-autopairs",
		"onsails/lspkind.nvim",
	},
	config = function()
		-- nvim-cmp setup goes here
		local cmp = require("cmp")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local luasnip = require("luasnip")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				-- Customize how completion items are displayed (optional)
				-- You might use a plugin like 'nvim-web-devicons' or 'lspkind.nvim' for icons.
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
			-- Other options like sorting, comparators, etc.
			matching = {
				disallow_fuzzy_matching = true,
			},
		})
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
