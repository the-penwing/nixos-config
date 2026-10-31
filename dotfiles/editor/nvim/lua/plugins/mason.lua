-- lua/plugins/mason.lua
return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"json-lsp",
				"yaml-language-server",
				"html-lsp",
				"css-lsp",
				"bash-language-server",
				"zls",
				"lua-language-server",
				"teal-language-server",
				"elm-language-server",
				"tombi",
				"stylua",
				"shfmt",
				"selene",
				"prettier",
				"shellcheck",
				"pyright",
				"ruff",
				"black",
				"yamlfmt",
				"yamllint",
				"elm-format",
				"just-lsp",
				"gopls",
				"goimports",
				"gofumpt",
			},
			run_on_start = true,
			start_delay = 3000, -- ms, gives lazy.nvim time to finish loading first
		},
	},
}
