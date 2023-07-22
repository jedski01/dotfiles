return {
	"rcarriga/nvim-notify",
  enabled = false,
	config = function()
		local notify = require("notify")
		vim.notify = notify
		notify.setup({
      background_colour = '#000000'
    })
	end,
}
