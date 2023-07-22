return {
	"rcarriga/nvim-notify",
  priority = 98,
  lazy = false,
	config = function()
		local notify = require("notify")
		vim.notify = notify
		notify.setup({
      background_colour = '#000000'
    })
	end,
}
