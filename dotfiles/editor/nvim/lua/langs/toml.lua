return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			tombi = {
				cmd = { "tombi", "lsp" },
				filetypes = { "toml" },
				root_markers = { "tombi.toml", "pyproject.toml", ".git" },
			},
		},
	},
}
