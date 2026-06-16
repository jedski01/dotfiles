-- Better completion highlights

local function setup_blink_highlights()
	-- Fuzzy match highlight - use a bright distinct color
	vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { link = "Special" })

	-- Default label colors
	vim.api.nvim_set_hl(0, "BlinkCmpLabel", { link = "Normal" })
	vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { link = "Comment" })
	vim.api.nvim_set_hl(0, "BlinkCmpLabelSnippet", { link = "String" })
	vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated", { link = "Comment", strikethrough = true })

	-- Source badge colors
	vim.api.nvim_set_hl(0, "BlinkCmpSource", { link = "Typedef" })

	-- Menu visual improvements
	vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Pmenu" })
	vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
	vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })

	-- Documentation window
	vim.api.nvim_set_hl(0, "BlinkCmpDoc", { link = "NormalFloat" })
	vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "FloatBorder" })

	-- Kind colors - use existing Neovim highlights where possible
	vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { link = "Function" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { link = "Function" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { link = "Identifier" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { link = "Structure" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { link = "Structure" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindStruct", { link = "Structure" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { link = "Property" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindField", { link = "Field" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindEnum", { link = "Structure" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindEnumMember", { link = "Constant" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { link = "Keyword" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { link = "Constant" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindConstructor", { link = "Function" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { link = "Include" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindText", { link = "Normal" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { link = "Label" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindFile", { link = "Directory" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindFolder", { link = "Directory" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindColor", { link = "Special" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindReference", { link = "Special" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindOperator", { link = "Operator" })
	vim.api.nvim_set_hl(0, "BlinkCmpKindTypeParameter", { link = "Type" })
end

local function setup_snacks_highlights()
	-- Snacks picker git file status - bright colors for dark background
	vim.api.nvim_set_hl(0, "SnacksPickerGitStatusAdded", { fg = "#a9dc76", bold = true })
	vim.api.nvim_set_hl(0, "SnacksPickerGitStatusModified", { fg = "#ffd866", bold = true })
	vim.api.nvim_set_hl(0, "SnacksPickerGitStatusDeleted", { fg = "#ff6188", bold = true })
	vim.api.nvim_set_hl(0, "SnacksPickerGitStatusRenamed", { fg = "#78dce8", bold = true })
	vim.api.nvim_set_hl(0, "SnacksPickerGitStatusUntracked", { fg = "#ab9df2", bold = true })

	-- Buffer flags (+, a, h, etc.)
	vim.api.nvim_set_hl(0, "SnacksPickerBufFlags", { fg = "#ffd866", bold = true })
end

local function setup_linenr_highlights()
	-- Relative line numbers - visible but subdued
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#727072" })
	-- Current line number - bright and bold for emphasis
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffd866", bold = true })
end

-- Setup highlights now and reload on colorscheme change
setup_blink_highlights()
setup_snacks_highlights()
setup_linenr_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		setup_blink_highlights()
		setup_snacks_highlights()
		setup_linenr_highlights()
	end,
})
