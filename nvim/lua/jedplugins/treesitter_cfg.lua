local ts_indent_filetypes = {
	typescript = true,
	typescriptreact = true,
	javascript = true,
	javascriptreact = true,
	html = true,
	css = true,
	scss = true,
	json = true,
	lua = true,
}

local function is_large_file(buf)
	local max_filesize = 100 * 1024 -- 100 KB
	local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
	return ok and stats and stats.size > max_filesize
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf = args.buf
					local ft = vim.bo[buf].filetype
					local lang = vim.treesitter.language.get_lang(ft) or ft
					if lang == "c" then return end
					if is_large_file(buf) then return end
					if not pcall(vim.treesitter.start, buf) then return end
					if ts_indent_filetypes[ft] then
						vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
					vim.wo.foldmethod = "expr"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			local select = require("nvim-treesitter-textobjects.select")
			local maps = {
				aa = "@parameter.outer",
				ia = "@parameter.inner",
				af = "@function.outer",
				["if"] = "@function.inner",
				aC = "@class.outer",
				iC = "@class.inner",
				al = "@loop.outer",
				il = "@loop.inner",
				ac = "@conditional.outer",
				ic = "@conditional.inner",
				ar = "@regex.outer",
				ir = "@regex.inner",
			}
			for lhs, query in pairs(maps) do
				vim.keymap.set({ "x", "o" }, lhs, function()
					select.select_textobject(query, "textobjects")
				end, { desc = "select " .. query })
			end
		end,
	},
}
