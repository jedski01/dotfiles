return {
  'echasnovski/mini.nvim',
  enabled = false,
  version = '*',
  config = function()
    require('mini.notify').setup({})
  end
}
