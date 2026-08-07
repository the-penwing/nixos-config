return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		keymap = {
			preset = "none",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<CR>"] = { "select_and_accept", "fallback" },
		},

		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 150,
			},
			menu = {
				auto_show = true,
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
					},
				},
			},
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		sources = {
			default = { "lsp", "snippets", "path", "buffer" },
			providers = {
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
					timeout_ms = 1000, -- Raised timeout: path resolution (like Vec::) requires stdlib lookup
					score_offset = 100,
				},
				buffer = {
					score_offset = -10,
					min_keyword_length = 4,
				},
			},
		},
	},
}
