return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			clangd = {
				cmd = { "clangd", "--query-driver=*gcc*,*clang*" },
			},
		},
	},
}
