return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "windwp/nvim-ts-autotag" },
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "lua", "javascript", "typescript", "html", "scss", "rust" },
				sync_install = true,
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				autotag = {
					enable = true,
					filetypes = { "html", "xml" },
				},
			})
			require("nvim-treesitter").setup()
		end,
	},
}
