return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
    local trouble = require("trouble");

    trouble.setup{
      height = 40
    }
		vim.keymap.set("n", "<leader>xx", function()
			trouble.open()
		end)
		vim.keymap.set("n", "<leader>xc", function()
			trouble.close()
		end)
		vim.keymap.set("n", "<leader>xw", function()
			trouble.open("workspace_diagnostics")
		end)
		vim.keymap.set("n", "<leader>xd", function()
			trouble.open("document_diagnostics")
		end)
		vim.keymap.set("n", "<leader>xq", function()
			trouble.open("quickfix")
		end)
		vim.keymap.set("n", "<leader>xl", function()
			trouble.open("loclist")
		end)
    vim.keymap.set("n", "[x", function()
      trouble.previous({ skip_groups = true, jump = true })
    end)
    vim.keymap.set("n", "]x", function()
      trouble.next({ skip_groups = true, jump = true })
    end)
		-- vim.keymap.set("n", "gR", function()
		-- 	require("trouble").open("lsp_references")
		-- end)
	end,
}
