return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    search = {
      multi_window = false,
      exclude = {
        "notify",
        "cmp_menu",
        "noice",
        "flash_prompt",
        "NvimTree",
        function(win)
          return not vim.api.nvim_win_get_config(win).focusable
        end
      }
    },
    treesitter_search = {
      multi_windows = false
    }
  },
  -- stylua: ignore
  keys = {
    -- { "", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "?", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
