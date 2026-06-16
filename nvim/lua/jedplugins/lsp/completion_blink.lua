return {
	"saghen/blink.cmp",
	version = "1.*",
	enabled = true,
	dependencies = {
		"rafamadriz/friendly-snippets",
	},

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			["<C-j>"] = { "select_next" },
			["<C-k>"] = { "select_prev" },
			["<CR>"] = { "select_and_accept", "fallback" },
			["<C-CR>"] = { "accept", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
			use_nvim_cmp_as_default = true,
		},

		completion = {
			accept = {
				auto_brackets = { enabled = true },
			},
			list = {
				selection = { preselect = true, auto_insert = false },
			},
			trigger = {
				show_in_snippet = false,
				show_on_trigger_character = true,
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = { border = "rounded" },
			},
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{ "kind_icon", gap = 1 },
						{ "label", "label_description", gap = 1 },
						{ "source" },
					},
					components = {
						kind_icon = {
							text = function(ctx)
								local icons = {
									Text = "",
									Method = "󰊕",
									Function = "󰊕",
									Constructor = "",
									Field = "󰇽",
									Variable = "󰂡",
									Class = "󰜁",
									Interface = "",
									Module = "",
									Property = "󰜢",
									Unit = "",
									Value = "󰎠",
									Enum = "",
									Keyword = "󰌋",
									Snippet = "󰒕",
									Color = "󰏘",
									Reference = "",
									File = "",
									Folder = "󰉋",
									EnumMember = "",
									Constant = "󰏿",
									Struct = "",
									Event = "",
									Operator = "󰆕",
									TypeParameter = "󰅲",
								}
								return icons[ctx.kind] or " "
							end,
							highlight = function(ctx)
								return "BlinkCmpKind" .. (ctx.kind or "")
							end,
						},
						label = {
							text = function(item)
								return item.label
							end,
							-- highlight = function(ctx)
							-- 	local label = ctx.label
							--
							-- 	if ctx.deprecated then
							-- 		return { { { 0, #label }, "BlinkCmpLabelDeprecated" } }
							-- 	end
							--
							-- 	if ctx.type == "snippet" then
							-- 		return { { { 0, #label }, "BlinkCmpLabelSnippet" } }
							-- 	end
							--
							-- 	local highlights = {}
							-- 	for _, idx in ipairs(ctx.label_matched_indices or {}) do
							-- 		table.insert(highlights, { { idx, idx + 1 }, "BlinkCmpLabelMatch" })
							-- 	end
							-- 	return highlights
							-- end,
						},
						label_description = {
							text = function(item)
								return item.label_description or ""
							end,
							highlight = "BlinkCmpLabelDescription",
						},
						source = {
							text = function(ctx)
								local source_name = ctx.source_name or "LSP"
								local formatted = string.sub(source_name, 1, 3):lower()
								return "[" .. formatted .. "]"
							end,
							highlight = "BlinkCmpSource",
						},
					},
				},
			},
		},

		signature = { enabled = true },

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				lsp = {
					min_keyword_length = 0,
					score_offset = 0,
				},
				path = {
					min_keyword_length = 0,
				},
				snippets = {
					min_keyword_length = 2,
				},
				buffer = {
					min_keyword_length = 3,
					max_items = 5,
				},
			},
		},

		fuzzy = { implementation = "rust" },
	},
	opts_extend = { "sources.default" },
}
