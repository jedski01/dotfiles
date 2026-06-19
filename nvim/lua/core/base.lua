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
-- depend on a (potentially stale) $DISPLAY. For paste we prefer xsel when an X
-- display is reachable; over plain SSH (no $DISPLAY) we fall back to an
-- in-session cache filled by the copy side, since OSC 52 read-back is unreliable
-- (kitty disables it by default) and xsel would error with "can't open display".
local osc52 = require("vim.ui.clipboard.osc52")

local clip_cache = { ["+"] = { "" }, ["*"] = { "" } }

local function make_copy(reg)
  local osc_copy = osc52.copy(reg)
  return function(lines, regtype)
    clip_cache[reg] = lines
    osc_copy(lines, regtype)
  end
end

-- Over SSH, $DISPLAY (e.g. ":0") points at the *remote* X server, but our OSC 52
-- yanks land in the *local* terminal's clipboard, so remote xsel reads an empty
-- selection. Detect SSH and avoid xsel there.
local in_ssh = (vim.env.SSH_TTY and vim.env.SSH_TTY ~= "")
  or (vim.env.SSH_CONNECTION and vim.env.SSH_CONNECTION ~= "")

-- Inside tmux (`set-clipboard on`), tmux captures our OSC 52 yanks into its own
-- paste buffer before forwarding them out. Reading that buffer gives us paste
-- that is shared across every pane/nvim instance — the cross-pane flow that
-- vim-tmux-clipboard used to provide.
local in_tmux = vim.env.TMUX and vim.env.TMUX ~= ""

local function make_paste(reg, xsel_args)
  return function()
    if not in_ssh and vim.env.DISPLAY and vim.env.DISPLAY ~= "" then
      return vim.fn.systemlist("xsel " .. xsel_args)
    end
    if in_tmux then
      local buf = vim.fn.systemlist("tmux save-buffer -")
      if vim.v.shell_error == 0 and not (#buf == 1 and buf[1] == "") then
        return buf
      end
    end
    return clip_cache[reg]
  end
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = make_copy("+"),
    ["*"] = make_copy("*"),
  },
  paste = {
    ["+"] = make_paste("+", "-ob"),
    ["*"] = make_paste("*", "-op"),
  },
}

vim.opt.updatetime = 300
vim.opt.confirm = true
vim.opt.modeline = false

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
