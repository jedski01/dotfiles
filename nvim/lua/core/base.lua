vim.opt.termguicolors = true

vim.g.mapleader = ","

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes:3"
vim.opt.wrap = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.list = true
vim.opt.listchars:append("trail:·")
vim.opt.listchars:append("tab:»·")

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 10
vim.opt.cmdheight = 1
vim.opt.mouse = ""

-- Terminal
vim.api.nvim_create_augroup("Terminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = { "term://*" },
  group = "Terminal",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.opt_local.signcolumn = "no"
	end,
})

