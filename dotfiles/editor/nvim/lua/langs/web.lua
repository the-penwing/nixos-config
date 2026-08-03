return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			ts_ls = { cmd = { "typescript-language-server", "--stdio" } },
			html = { cmd = { "vscode-html-language-server", "--stdio" } },
			cssls = { cmd = { "vscode-css-language-server", "--stdio" } },
			tailwindcss = { cmd = { "tailwindcss-language-server", "--stdio" } },
		},
	},
}
