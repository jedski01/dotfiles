require('bufferline').setup({
  options = {
    diagnostics = 'nvim_lsp',
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'Files',
        separator = true
      }
    }
  }
})

vim.cmd([[highlight! link BufferLineOffsetSeparator NvimTreeVertSplit]])
