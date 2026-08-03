return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			kotlin_language_server = {
				root_dir = function(bufnr)
					return vim.fs.root(bufnr, { "build.gradle", "build.gradle.kts", "pom.xml", ".git" })
				end,
				settings = {
					kotlin = {
						linting = { enabled = true },
					},
				},
			},
		},
	},
}
