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
			elm = { "elm-format" },
			just = { "just" },
			gleam = { "gleam" },
			go = { "goimports", "gofumpt" },
		},
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2", "-ci" },
			},
			["elm-format"] = {
				command = "elm-format",
				args = { "--stdin" },
			},
			just = {
				prepend_args = { "--fmt" },
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
