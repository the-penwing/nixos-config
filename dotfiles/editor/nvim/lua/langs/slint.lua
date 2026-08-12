return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			slint_lsp = {
				cmd = { "slint-lsp" },
				filetypes = { "slint" },
			},
		},
	},
}
