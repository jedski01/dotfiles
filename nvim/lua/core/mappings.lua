local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

-- Buffer navigation
vim.keymap.set("n", "<Space>h", ":bf<CR>", opts("First buffer"))
vim.keymap.set("n", "<Space>k", ":bn<CR>", opts("Next buffer"))
vim.keymap.set("n", "<Space>j", ":bp<CR>", opts("Previous buffer"))
vim.keymap.set("n", "<Space>l", ":bl<CR>", opts("Last buffer"))
vim.keymap.set("n", "<Space>;", ":bd<CR>", opts("Delete buffer"))
vim.keymap.set("n", "<Space>d", ":%bd<CR>", opts("Delete all buffers"))

-- Quickfix shortcuts
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", opts("Next quickfix entry"))
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", opts("Previous quickfix entry"))
vim.keymap.set("n", "qc", "<cmd>cclose<CR>", opts("Close quickfix window"))
vim.keymap.set("n", "qo", "<cmd>botright cwindow 40<CR>", opts("Open quickfix window"))

-- rename append
vim.keymap.set("n", "<leader>ra", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts("Rename word (append)"))
-- rename replace
vim.keymap.set("n", "<leader>rr", ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>", opts("Rename word (replace)"))

-- tabs
vim.keymap.set("n", "th", ":tabfirst<CR>", opts("First tab"))
vim.keymap.set("n", "tl", ":tablast<CR>", opts("Last tab"))
vim.keymap.set("n", "tj", ":tabprev<CR>", opts("Previous tab"))
vim.keymap.set("n", "tk", ":tabnext<CR>", opts("Next tab"))
vim.keymap.set("n", "tt", ":tabedit<CR>", opts("New tab"))
vim.keymap.set("n", "td", ":tabclose<CR>", opts("Close tab"))
vim.keymap.set("n", "tn", ":tabnew %<CR>", opts("Open current buffer in new tab"))
vim.keymap.set("n", "to", ":tabonly<CR>", opts("Close other tabs"))
vim.keymap.set("n", "ts", ":tab split<CR>", opts("Split current window into new tab"))

-- quick save and close
vim.keymap.set("n", "<leader>s", ":w<CR>", opts("Save file"))
vim.keymap.set("n", "<leader>q", ":x<CR>", opts("Save and close window"))

-- vim shortcuts (fugitive)
vim.keymap.set("n", "<leader>gfc", ":G log --oneline -- %<CR>", opts("Git log for current file"))
vim.keymap.set({ "v", "n" }, "<leader>gl", function()
    vim.cmd("G log --pretty=oneline -L" .. vim.fn.line("v") .. "," .. vim.fn.line(".") .. ":" .. vim.fn.expand("%:p"))
end, opts("Git log for selected lines"))

-- moar motions
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts("Half page down (centered)"))
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts("Half page up (centered)"))
vim.keymap.set("n", "n", "nzzzv", opts("Next search result (centered)"))
vim.keymap.set("n", "N", "Nzzzv", opts("Previous search result (centered)"))

vim.keymap.set("n", "L", "J$", opts("Join line below and jump to end"))
vim.keymap.set("v", "L", "J", opts("Join selected lines"))
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts("Move selection down"))
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts("Move selection up"))

-- moar copy
vim.keymap.set("x", "<leader>p", '"_dp', opts("Paste without yanking selection"))
vim.keymap.set("n", "<leader>y", '"+y', opts("Yank to clipboard"))
vim.keymap.set("v", "<leader>y", '"+y', opts("Yank to clipboard"))
vim.keymap.set("n", "<leader>Y", '"+Y', opts("Yank line to clipboard"))

-- NOPE
vim.keymap.set("n", "Q", "<nop>", opts("Disable Ex mode"))

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, desc = "Exit terminal mode" })
vim.keymap.set("n", "<space>t", function() require("snacks").terminal.toggle() end, { desc = "Toggle terminal" })
