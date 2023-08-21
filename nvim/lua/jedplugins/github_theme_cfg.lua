return {
	"projekt0n/github-nvim-theme",
  -- enabled = false,
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
  opts = {
    options = {
      dim_inactive = true
    },
    groups = {
      all = {
        BufferLineOffsetSeparator = { fg = 'bg3', bg = 'bg3' },
      }
    }

  },
  config = function()
    vim.cmd("colorscheme github_dark_dimmed")
  end
}
