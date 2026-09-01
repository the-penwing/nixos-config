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
				"clangd",
				"typescript-language-server",
				"html-lsp",
				"css-lsp",
				"tailwindcss-language-server",
				"bash-language-server",
				"zls",
				"marksman",
				"lua-language-server",
				"kotlin-language-server",
				"elm-language-server",
				"tombi",
				"stylua",
				"shfmt",
				"markdownlint-cli2",
				"selene",
				"prettier",
				"shellcheck",
				"eslint_d",
				"black",
				"yamlfmt",
				"yamllint",
				"ktlint",
				"elm-format",
			},
			run_on_start = true,
			start_delay = 3000, -- ms, gives lazy.nvim time to finish loading first
		},
	},
}
