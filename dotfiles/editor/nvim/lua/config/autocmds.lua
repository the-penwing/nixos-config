-- LSP keymaps, only active in buffers with an attached client
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, opts)
	end,
})

-- Gitsigns keymaps, only active in buffers gitsigns has attached to
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local ok, gitsigns = pcall(require, "gitsigns")
		if not ok then
			return
		end
		local opts = { buffer = true }
		vim.keymap.set("n", "]h", gitsigns.next_hunk, vim.tbl_extend("force", opts, { desc = "Next hunk" }))
		vim.keymap.set("n", "[h", gitsigns.prev_hunk, vim.tbl_extend("force", opts, { desc = "Prev hunk" }))
		vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
		vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
		vim.keymap.set("n", "<leader>hb", gitsigns.blame_line, vim.tbl_extend("force", opts, { desc = "Blame line" }))
		vim.keymap.set(
			"n",
			"<leader>hp",
			gitsigns.preview_hunk,
			vim.tbl_extend("force", opts, { desc = "Preview hunk" })
		)
	end,
})
