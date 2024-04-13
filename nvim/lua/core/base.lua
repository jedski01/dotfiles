vim.g.termdebug_wide = 163
vim.opt.termguicolors = true
vim.opt.shell = "fish"
vim.o.background = "dark"

vim.g.mapleader = ","

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes:1"
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

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { "c", "cpp", "h", "json" },
--   callback = function()
--     vim.opt_local.tabstop = 4
--     vim.opt_local.shiftwidth = 4
--     vim.opt_local.expandtab = true
--   end
-- })

-- local function moveBufferTo(direction)
--     local bufPath = vim.api.nvim_buf_get_name(0)
--     -- Go to alternate file. Save as CTRL-6
--     vim.api.nvim_exec('e#', true)
--     -- Move to the new window
--     vim.api.nvim_exec('wincmd ' .. direction, true)
--     -- Open the previous buffer
--     vim.api.nvim_exec('edit' .. bufPath, true)
-- end
--
-- -- Move current buffer to existing window
-- vim.keymap.set("n", "<C-w>L", function() moveBufferTo('l') end, { silent = true })
-- vim.keymap.set("n", "<C-w>H", function() moveBufferTo('h') end, { silent = true })
-- vim.keymap.set("n", "<C-w>J", function() moveBufferTo('j') end, { silent = true })
-- vim.keymap.set("n", "<C-w>K", function() moveBufferTo('k') end, { silent = true })
