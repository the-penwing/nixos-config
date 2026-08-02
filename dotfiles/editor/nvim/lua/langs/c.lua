return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			clangd = {
				cmd = { "/run/current-system/sw/bin/clangd" },
				settings = {},
			},
		},
	},
}
