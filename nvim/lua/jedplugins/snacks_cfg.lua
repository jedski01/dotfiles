local dropdown = {
  layout = {
    backdrop = false,
    row = 5,
    width = 0.6,
    min_width = 80,
    height = 0.8,
    border = "none",
    box = "vertical",
    {
      box = "vertical",
      border = "rounded",
      title = "{title} {live} {flags}",
      title_pos = "center",
      { win = "input", height = 1,     border = "bottom" },
      { win = "list",  border = "none" },
    },
    { win = "preview", title = "{preview}", height = 0.7, border = "rounded" },
  }
}

return {
  "folke/snacks.nvim",
  opts = {
    picker = {},
    explorer = {}
  },
  keys = {
    -- Files
    { "<leader>ff", function() Snacks.picker.files() end,                               desc = "Files" },
    { "<leader>fe", function() Snacks.picker.files({ cwd = vim.fn.expand("%:h") }) end, desc = "Files in directory" },
    { "<leader>fp", function() Snacks.picker.git_files() end,                           desc = "Git files" },

    -- Angular specific
    {
      "<leader>fa",
      function()
        Snacks.picker.files({
          args = { "-t", "f", "-e", "ts", "-e", "html", "-e", "scss", "-e", "css", "-E", "*.spec.ts" },
          layout = { title = "Angular files" }
        })
      end,
      desc = "Angular files"
    },

    { "<leader>fu",  function() Snacks.picker.git_files() end,                      desc = "Angular unit test files" },

    -- LSP
    {
      "<leader>ft",
      function()
        Snacks.picker.lsp_symbols({
          layout = { preset = "ivy", preview = "main" },
          main = { current = true }
        })
      end,
      desc = "LSP symbols"
    },

    -- Grep
    { "<leader>fg",  function() Snacks.picker.grep() end,                           desc = "Grep" },
    { "<leader>fib", function() Snacks.picker.lines() end,                          desc = "Buffer lines" },
    { "<leader>fw",  function() Snacks.picker.grep_word({ layout = dropdown }) end, desc = "Visual selection or word", mode = { "n", "x" } },

    -- Buffers
    { "<leader>fb",  function() Snacks.picker.buffers({ layout = dropdown }) end,   desc = "Buffers" },

    { "<leader>fq",  function() Snacks.picker.qflist() end,                         desc = "Quickfix list" },

    -- Git
    { "<leader>gb",  function() Snacks.picker.git_branches() end,                   desc = "Git branches" },
    { "<leader>gfh", function() Snacks.picker.git_log_file() end,                   desc = "Git log file" },
    { "<leader>glh", function() Snacks.picker.git_log_line() end,                   desc = "Git log line" },

    -- search
    { "<leader>fD",  function() Snacks.picker.diagnostics() end,                    desc = "Diagnostics" },
    {
      "<leader>fd",
      function()
        Snacks.picker.diagnostics_buffer({
          layout = { preset = "ivy", preview = "main" },
          main = { current = true }
        })
      end,
      desc = "Buffer Diagnostics"
    },
  }
}
