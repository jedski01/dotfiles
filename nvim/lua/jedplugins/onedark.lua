local color = require('onedark.palette')

require('onedark').setup {
  style = 'warmer',
  term_colors = true,
  colors = {
    fg = '#e8e8e8',
    dark_purple = '#cf5fc4'
  },
  highlights = {
    TelescopePromptBorder = { bg='$diff_text', fg='$diff_text' },
    TelescopeResultsBorder = { bg='$bg1', fg='$bg1' },
    TelescopePreviewBorder = { bg='$bg1', fg='$bg1' },
    TelescopeBorder = { bg='$diff_text', fg='$fg' },
    TelescopePromptPrefix = { fg ='$fg' },
    IndentBlanklineContextChar = { fg='$orange', gui='nocombine' }
  },
  diagnostics = {
    undercurl = true
  }
}

require('onedark').load()

vim.cmd('colorscheme onedark')

vim.api.nvim_set_hl(0, 'FloatBorder', { bg=color.warmer.bg0, fg=color.warmer.fg })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg=color.warmer.bg0 })
vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg=color.warmer.diff_text })
vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg=color.warmer.bg1 })
vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg=color.warmer.bg1 })
vim.api.nvim_set_hl(0, 'TelescopePromptCounter', { fg='#e8e8e8' })
vim.api.nvim_set_hl(0, 'CursorLine', { bg=color.warmer.bg3 })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg=color.warmer.orange })
vim.api.nvim_set_hl(0, 'FidgetTask', { bg=color.warmer.bg0, fg='#e8e8e8'})
vim.api.nvim_set_hl(0, 'FidgetTitle', { bg=color.warmer.bg0, fg=color.warmer.orange })
vim.api.nvim_set_hl(0, 'MarkSignHL', { fg=color.warmer.blue })
