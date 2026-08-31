return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			kotlin_language_server = {
				init_options = {
					storagePath = vim.fn.stdpath("cache") .. "/kotlin_language_server",
				},
				root_markers = {
					"build.gradle",
					"build.gradle.kts",
					"pom.xml",
					"settings.gradle",
					"settings.gradle.kts",
					".git",
				},
				settings = {
					kotlin = {
						linting = { enabled = true },
					},
				},
			},
		},
	},
}
