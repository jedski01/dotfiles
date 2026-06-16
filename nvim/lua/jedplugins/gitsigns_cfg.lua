return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signcolumn = true,
			-- Skip large files to avoid performance issues
			max_file_length = 5000,
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
        vim.keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end, { buffer = bufnr, desc = "Blame line" })
        vim.keymap.set({ 'n', 'v'}, '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { buffer = bufnr, desc = "Reset hunk" })
        vim.keymap.set({ 'n', 'v'}, '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
        vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
        vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle current line blame" })
        vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })

				-- Navigation
				vim.keymap.set("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.nav_hunk("next")
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Next hunk" })

				vim.keymap.set("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.nav_hunk("prev")
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Previous hunk" })
			end,
		})
	end,
}
