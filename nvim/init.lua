vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('core')
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/site")
require("lazy").setup({
  spec = {
    { import = 'jedplugins' },
    { import = 'jedplugins.lsp' }
  },
  install = { colorscheme = { 'monokai-pro' } },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = { 'gzip', 'tarPlugin', 'zipPlugin', 'tohtml', 'tutor' }
    }
  }
})
require("lsp")
