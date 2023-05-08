require('nvim-treesitter.configs').setup({
  ensure_installed = { 'c', 'lua', 'javascript', 'typescript', 'html', 'scss', 'rust' },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true
  },
  autotag = {
    enable = true,
    filetypes = { 'html', 'xml' }
  }
})

require('nvim-treesitter').setup()