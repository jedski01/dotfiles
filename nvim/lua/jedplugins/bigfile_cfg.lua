return {
	"LunarVim/bigfile.nvim",
	config = function()
		require("bigfile").setup({
			pattern = function(bufnr, filesize_mib)
				local filetype = vim.filetype.match({ buf = bufnr })
				if filesize_mib >= 1 and (filetype == "json" or filetype == "jsonc") then
					return true
				end
				return false
			end,
			features = {
				"indent_blankline",
				"treesitter",
			},
		})
	end,
}
