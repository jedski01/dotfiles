local hop = require("hop")

hop.setup();
local silentopts = { noremap = true, silent = true }

vim.api.nvim_set_keymap(
  "n",
  "<leader>hw",
  '<cmd>lua require("hop").hint_words()<CR>',
  silentopts
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>hh",
  '<cmd>lua require("hop").hint_words({ current_line_only = true})<CR>',
  silentopts
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>hl",
  '<cmd>lua require("hop").hint_lines()<CR>',
  silentopts
)
