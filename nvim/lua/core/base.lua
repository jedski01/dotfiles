vim.g.termdebug_wide = 163
vim.opt.termguicolors = true
vim.opt.shell = "fish"
vim.o.background = "dark"
vim.o.backupcopy = "yes"

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
-- vim.opt.cmdheight = 0

vim.opt.undofile = true
vim.opt.undolevels = 10000

vim.o.winborder = "rounded"

vim.opt.clipboard = "unnamedplus"

-- Copy to the system clipboard via OSC 52 so yanks survive tmux/SSH and don't
-- depend on a (potentially stale) $DISPLAY. Paste stays on the local provider.
local osc52 = require("vim.ui.clipboard.osc52")
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = osc52.copy("+"),
    ["*"] = osc52.copy("*"),
  },
  paste = {
    ["+"] = function()
      return vim.fn.systemlist("xsel -ob")
    end,
    ["*"] = function()
      return vim.fn.systemlist("xsel -op")
    end,
  },
}

vim.opt.updatetime = 300
vim.opt.confirm = true
vim.opt.modeline = false

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
