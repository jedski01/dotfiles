local silentopts = { noremap = true, silent = true }

-- Buffer navigation
vim.api.nvim_set_keymap("n", "<Space>h", ":bf<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<Space>k", ":bn<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<Space>j", ":bp<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<Space>l", ":bl<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<Space>;", ":bd<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<Space>d", ":%bd<CR>", silentopts)

-- Quickfix shortcuts
vim.api.nvim_set_keymap("n", "]q", "<cmd>cnext<CR>zz", silentopts)
vim.api.nvim_set_keymap("n", "[q", "<cmd>cprev<CR>zz", silentopts)
vim.api.nvim_set_keymap("n", "qc", "<cmd>cclose<CR>", silentopts)
vim.api.nvim_set_keymap("n", "qo", "<cmd>botright cwindow 40<CR>", silentopts)

-- rename append
vim.api.nvim_set_keymap("n", "<leader>ra", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", silentopts)
-- rename replace
vim.api.nvim_set_keymap("n", "<leader>rr", ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>", silentopts)

-- tabs
vim.api.nvim_set_keymap("n", "th", ":tabfirst<CR>", silentopts)
vim.api.nvim_set_keymap("n", "tl", ":tablast<CR>", silentopts)
vim.api.nvim_set_keymap("n", "tj", ":tabprev<CR>", silentopts)
vim.api.nvim_set_keymap("n", "tk", ":tabnext<CR>", silentopts)
vim.api.nvim_set_keymap("n", "tt", ":tabedit<CR>", silentopts)
vim.api.nvim_set_keymap("n", "td", ":tabclose<CR>", silentopts)
vim.api.nvim_set_keymap("n", "tn", ":tabnew %<CR>", silentopts)
vim.api.nvim_set_keymap("n", "to", ":tabonly<CR>", silentopts)
vim.api.nvim_set_keymap("n", "ts", ":tab split<CR>", silentopts)

-- code action
-- vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>CodeActionMenu<CR>", silentopts)

-- quick save and close
vim.api.nvim_set_keymap("n", "<leader>s", ":w<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<leader>q", ":x<CR>", silentopts)

-- vim shortcuts
vim.api.nvim_set_keymap("n", "<leader>gfh", ":G log --follow -p -5 -- %<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<leader>gfc", ":G log --oneline -- %<CR>", silentopts)
vim.keymap.set( {"v", "n" }, "<leader>gl", function()
    vim.cmd("G log --pretty=oneline -L" .. vim.fn.line("v") .. "," .. vim.fn.line(".") .. ":" .. vim.fn.expand("%:p"))
end, {})
vim.api.nvim_set_keymap("n", "<leader>gs", ":0G<CR>", silentopts)

-- moar motions
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", silentopts)
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", silentopts)
vim.api.nvim_set_keymap("n", "n", "nzzzv", silentopts)
vim.api.nvim_set_keymap("n", "N", "Nzzzv", silentopts)

vim.api.nvim_set_keymap("n", "L", "J$", silentopts)
vim.api.nvim_set_keymap("v", "L", "J", silentopts)
vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", silentopts)
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", silentopts)

-- moar copy
vim.api.nvim_set_keymap("x", "<leader>p", '"_dp', silentopts)
vim.api.nvim_set_keymap("n", "<leader>y", '"+y', silentopts)
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', silentopts)
vim.api.nvim_set_keymap("n", "<leader>Y", '"+Y', silentopts)

-- NOPE
vim.api.nvim_set_keymap("n", "Q", "<nop>", silentopts)

-- Window navigation
vim.api.nvim_set_keymap("n", "<C-h>", ":wincmd h<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<C-j>", ":wincmd j<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<C-k>", ":wincmd k<CR>", silentopts)
vim.api.nvim_set_keymap("n", "<C-l>", ":wincmd l<CR>", silentopts)
