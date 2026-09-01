-- lua/langs/slint.lua
return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.config("slint_lsp", {
			cmd = { "slint-lsp" },
			filetypes = { "slint" },
		})
		vim.lsp.enable("slint_lsp")
	end,
}
