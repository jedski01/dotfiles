return {
	filetypes = { 'html' },
	root_markers = { 'package.json', '.git' },
	on_attach = function(client, bufnr)
		-- Disable html LSP in Angular projects to avoid conflicts with angularls
		local root = vim.fs.root(bufnr, { 'angular.json', 'project.json' })
		if root then
			vim.schedule(function()
				vim.lsp.buf_detach_client(bufnr, client.id)
			end)
		end
	end,
}
