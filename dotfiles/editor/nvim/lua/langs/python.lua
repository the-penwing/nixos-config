-- lua/langs/python.lua
return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("pyright", { cmd = { "pyright-langserver", "--stdio" } })
			vim.lsp.enable("pyright")
			vim.lsp.config("ruff", { cmd = { "ruff", "server" } })
			vim.lsp.enable("ruff")
		end,
	},
	{
		"jim-at-jibba/micropython.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
		config = function()
			require("micropython_nvim").setup()
		end,
	},
}
