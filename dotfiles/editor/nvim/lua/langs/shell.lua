return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			bashls = {
				cmd = { "bash-language-server", "start" },
			},
		},
	},
}
