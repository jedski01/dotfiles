return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"arkav/lualine-lsp-progress",
	},
	config = function()
		local utils = require("lualine.utils.utils")
		local highlight = require("lualine.highlight")
		-- Required to properly set the colors.
		-- local nc = require("nordic.colors")
    -- local c = {
      -- error = nc.error,
      -- warn = nc.warn,
      -- info = nc.info,
      -- hint = nc.hint,
      -- fg = nc.gray3,
      -- green = nc.green.base,
      -- blue = nc.blue0,
      -- orange = nc.orange.base
    -- }

    local ghc = require('github-theme.palette').load('github_dark_dimmed')
    local c = {
      error = ghc.red.base,
      warn = ghc.yellow.base,
      info = ghc.blue.base,
      hint = ghc.cyan.base,
      fg = ghc.fg1,
      green = ghc.green.base,
      blue = ghc.blue.base,
      orange = ghc.orange.base
    }

		local diagnostics_message = require("lualine.component"):extend()

		diagnostics_message.default = {
			colors = {
				error = utils.extract_color_from_hllist(
					{ "fg", "sp" },
					{ "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
					c.error
				),
				warning = utils.extract_color_from_hllist(
					{ "fg", "sp" },
					{ "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
					c.warn
				),
				info = utils.extract_color_from_hllist(
					{ "fg", "sp" },
					{ "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
					c.info
				),
				hint = utils.extract_color_from_hllist(
					{ "fg", "sp" },
					{ "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffAdd" },
					c.hint
				),
			},
		}
		function diagnostics_message:init(options)
			diagnostics_message.super:init(options)
			self.options.colors = vim.tbl_extend("force", diagnostics_message.default.colors, self.options.colors or {})
			self.highlights = { error = "", warn = "", info = "", hint = "" }
			self.highlights.error = highlight.create_component_highlight_group(
				{ fg = self.options.colors.error },
				"diagnostics_message_error",
				self.options
			)
			self.highlights.warn = highlight.create_component_highlight_group(
				{ fg = self.options.colors.warn },
				"diagnostics_message_warn",
				self.options
			)
			self.highlights.info = highlight.create_component_highlight_group(
				{ fg = self.options.colors.info },
				"diagnostics_message_info",
				self.options
			)
			self.highlights.hint = highlight.create_component_highlight_group(
				{ fg = self.options.colors.hint },
				"diagnostics_message_hint",
				self.options
			)
		end

		function diagnostics_message:update_status(is_focused)
			local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
			local diagnostics = vim.diagnostic.get(0, { lnum = r - 1 })
			if #diagnostics > 0 then
				local diag = diagnostics[1]
				for _, d in ipairs(diagnostics) do
					if d.severity < diag.severity then
						diagnostics = d
					end
				end
				local icons = { " ", " ", " ", " " }
				local hl = { self.highlights.error, self.highlights.warn, self.highlights.info, self.highlights.hint }
				return highlight.component_format_highlight(hl[diag.severity])
					.. icons[diag.severity]
					.. " "
					.. diag.message
			else
				return ""
			end
		end

		-- LSP clients attached to buffer
		local clients_lsp = function()
			local bufnr = vim.api.nvim_get_current_buf()

			local clients = vim.lsp.buf_get_clients(bufnr)
			if next(clients) == nil then
				return ""
			end

			local c = {}
			for _, client in pairs(clients) do
				table.insert(c, " " .. client.name)
			end
			return table.concat(c, "  ")
		end

		require("lualine").setup({
			sections = {
				lualine_a = {
					{
						"mode",
						separator = { right = " ", left = "" },
					},
				},
				lualine_b = {
					"branch",
					{
						"diff",
						padding = { right = 1 },
						color = { fg = c.fg },
						icon = { " ", color = { fg = c.fg } },
						symbols = { added = " ", modified = " ", removed = " " },
						diff_color = {
							added = { fg = c.green },
							modified = { fg = c.blue },
							removed = { fg = c.orange },
						},
					},
				},
				lualine_c = {
					"filename",
					{
						"diagnostics",
						sources = { "nvim_lsp", "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = "󱤅 ", other = "󰠠 " },
						diagnostics_color = {
							error = { fg = c.error },
							warn = { fg = c.warn },
							info = { fg = c.info },
							hint = { fg = c.hint },
						},
						colored = true,
						padding = 1,
					},
					{
						diagnostics_message,
						colors = {
							error = c.error,
							warn = c.warn,
							info = c.info,
							hint = c.hint,
						},
					},
				},
				lualine_x = { "lsp_progress", clients_lsp },
				lualine_y = { "encoding", "fileformat", "filetype" },
				lualine_z = {
					{
						"location",
						icon = { "", align = "left", color = { fg = c.black } },
					},
					{
						"progress",
						icon = { "", align = "left", color = { fg = c.black } },
						separator = { right = "", left = "" },
					},
				},
			},
			options = {
				-- theme = "onedark",
				-- theme = "catppuccin-mocha",
				-- theme = "nordic",
				section_separators = { left = " ", right = " " },
				component_separators = { left = "", right = "" },
				globalstatus = true,
				disabled_filetypes = { "packer", "dashboard", "NvimTree" },
			},
		})
	end,
}
