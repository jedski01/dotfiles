return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  enabled = false,
  opts = {},
  config = function()
		vim.cmd("colorscheme tokyonight-night")
  end
}
