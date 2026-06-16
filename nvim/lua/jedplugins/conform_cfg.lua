return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
	keys = {
		{
			"<space>f",
			function()
				require("conform").format({
					async = true,
					formatters = { "prettierd", "prettier" },
					lsp_fallback = false,
				})
			end,
			mode = "",
			desc = "Format buffer (prettier)",
		},
		{
			"<space>l",
			function()
				require("conform").format({
					async = true,
					formatters = { "eslint_d" },
					lsp_fallback = false,
				})
			end,
			mode = "",
			desc = "Format buffer (linter)",
		},
	},
	config = function()
		local conform = require("conform")

		local function js_formatters(bufnr)
			return {
				conform.get_formatter_info("prettierd", bufnr).available
						and "prettierd"
					or "prettier",
				"eslint_d",
			}
		end

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = js_formatters,
				typescript = js_formatters,
				javascriptreact = js_formatters,
				typescriptreact = js_formatters,
				html = js_formatters,
				scss = js_formatters,
				css = js_formatters,
			rust = { "rustfmt", lsp_format = "fallback" },
			},
		})
	end,
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
