return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	opts = {
		formatters_by_ft = {
			rust = { "rustfmt" },
			zig = { "zigfmt" },
			nix = { "alejandra" },
			markdown = { "prettier" },
			lua = { "stylua" },
		},
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2", "-ci" },
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
