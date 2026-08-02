return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		keymap = { preset = "default" },
		sources = {
			default = { "lsp", "snippets" },
			providers = {
				buffer = { enabled = false },
			},
		},
	},
}
