local augroup = vim.api.nvim_create_augroup("CoreAutocmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	desc = "Highlight yanked text",
	callback = function()
		vim.hl.on_yank({ timeout = 150 })
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if ft == "gitcommit" or ft == "gitrebase" then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	group = augroup,
	desc = "Equalize windows on resize",
	callback = function()
		local tab = vim.api.nvim_get_current_tabpage()
		vim.cmd("tabdo wincmd =")
		if vim.api.nvim_tabpage_is_valid(tab) then
			vim.api.nvim_set_current_tabpage(tab)
		end
	end,
})
