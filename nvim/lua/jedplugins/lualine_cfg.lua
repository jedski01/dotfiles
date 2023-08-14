return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"arkav/lualine-lsp-progress",
	},
	config = function()
		local utils = require("lualine.utils.utils")
		local highlight = require("lualine.highlight")

		local diagnostics_message = require("lualine.component"):extend()

		diagnostics_message.default = {
			colors = {
				error = utils.extract_color_from_hllist(
					{ "fg", "sp" },
					{ "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
					"#e32636"
				),
				warning = utils.extract_color_from_hllist(
					{ "fg", "sp" },
					{ "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
					"#ffa500"
				),
				info = utils.extract_color_from_hllist(
					{ "fg", "sp" },
					{ "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
					"#ffffff"
				),
				hint = utils.extract_color_from_hllist(
					{ "fg", "sp" },
					{ "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffAdd" },
					"#273faf"
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
		-- Required to properly set the colors.
		local c = require("nordic.colors")

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
						color = { fg = c.gray3 },
						icon = { " ", color = { fg = c.gray3 } },
						symbols = { added = " ", modified = " ", removed = " " },
						diff_color = {
							added = { fg = c.green.base },
							modified = { fg = c.blue0 },
							removed = { fg = c.orange.base },
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
				lualine_x = { "lsp_progress" },
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
				theme = "nordic",
				section_separators = { left = " ", right = " " },
				component_separators = { left = "", right = "" },
				globalstatus = true,
				disabled_filetypes = { "packer", "dashboard", "NvimTree" },
			},
		})
	end,
}
