local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-live-grep-args.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	"nvim-telescope/telescope-dap.nvim",

	-- THEME/GUI
	"rcarriga/nvim-notify",
	"j-hui/fidget.nvim",
	"navarasu/onedark.nvim",
	"lukas-reineke/indent-blankline.nvim",
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
	},

	-- Git
	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",

	-- QoL
	"ntpeters/vim-better-whitespace",
	{ "phaazon/hop.nvim", branch = "v2" },
	"terrortylor/nvim-comment",
	"kylechui/nvim-surround",
	"roxma/vim-tmux-clipboard",
	"windwp/nvim-autopairs",
	"windwp/nvim-ts-autotag",
	"mbbill/undotree",
	"weilbith/nvim-code-action-menu",
	"chentoast/marks.nvim",
	"softoika/ngswitcher.vim",
  "mg979/vim-visual-multi",

	-- LSP
	"onsails/lspkind.nvim",
	"jose-elias-alvarez/null-ls.nvim",
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
		},
	},

	-- DAP
	"jay-babu/mason-nvim-dap.nvim",
	-- Debugging
	"mfussenegger/nvim-dap",
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	-- Nodejs
	{ "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
}
local opts = {}
require("lazy").setup(plugins, opts)
