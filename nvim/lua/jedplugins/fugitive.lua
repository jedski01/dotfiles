local silentopts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>gfh", ":G log --follow -p -5 -- %<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<leader>gs", ":0G<CR>", silentopts)
