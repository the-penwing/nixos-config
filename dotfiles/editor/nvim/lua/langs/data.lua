return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			jsonls = { cmd = { "vscode-json-language-server", "--stdio" } },
			yamlls = { cmd = { "yaml-language-server", "--stdio" } },
			taplo = {},
		},
	},
}
