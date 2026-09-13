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
			kotlin = { "ktlint" },
		},
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2", "-ci" },
			},
			elm_format = {
				prepend_args = { "--yes" },
			},
		},
		format_on_save = function(bufnr)
			if vim.bo[bufnr].filetype == "kotlin" then
				return { timeout_ms = 3000, lsp_fallback = false }
			end
			return { timeout_ms = 500, lsp_fallback = true }
		end,
	},
}
