return {
	"williamboman/mason.nvim",
	opts = {},
	dependencies = {
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				auto_update = false,
				ensure_installed = {
					"angular-language-server",
					"bash-language-server",
					"clangd",
					"css-lsp",
					"eslint-lsp",
					"gopls",
					"html-lsp",
					"js-debug-adapter",
					"json-lsp",
					"lua-language-server",
					"rust-analyzer",
					"vtsls",
				},
			},
		},
	},
}
