return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			nil_ls = {},
			nixd = {
				settings = {
					nixd = {
						formatting = { command = { "alejandra" } },
					},
				},
			},
		},
	},
}
