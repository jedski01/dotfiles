  return {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup {
				on_attach = function(client, bufnr)
					local opts = { noremap = true, silent = true }
					local buf_keymap = vim.api.nvim_buf_set_keymap
          buf_keymap(bufnr, "n", "<leader>toi", ":TSToolsOrganizeImports<CR>", opts)
          buf_keymap(bufnr, "n", "<leader>tsi", ":TSToolsSortImports<CR>", opts)
          buf_keymap(bufnr, "n", "<leader>tru", ":TSToolsRemoveUnusedImports<CR>", opts)
          buf_keymap(bufnr, "n", "<leader>tfa", ":TSToolsFixAll<CR>", opts)
          buf_keymap(bufnr, "n", "<leader>tmi", ":TSToolsAddMissingImports<CR>", opts)
          buf_keymap(bufnr, "n", "<leader>trf", ":TSToolsRenameFile<CR>", opts)
          buf_keymap(bufnr, "n", "<leader>tfr", ":TSToolsFieReferences<CR>", opts)
        end
      }
    end,
  }
