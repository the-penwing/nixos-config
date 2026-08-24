return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			elmls = {
				cmd = { "elm-language-server" },
			},
		},
	},
}
