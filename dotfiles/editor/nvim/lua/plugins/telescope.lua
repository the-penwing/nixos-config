-- lua/plugins/telescope.lua
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({})
		telescope.load_extension("fzf")

		local builtin = require("telescope.builtin")
		-- find/grep
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
		-- LSP navigation
		vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "LSP References" })
		vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "LSP Definitions" })
		-- Symbols
		vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
		vim.keymap.set("n", "<leader>fS", builtin.lsp_dynamic_workspace_symbols, { desc = "Workspace symbols" })
	end,
}
