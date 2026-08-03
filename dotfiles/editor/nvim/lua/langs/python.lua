return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = { cmd = { "pyright-langserver", "--stdio" } },
				ruff = { cmd = { "ruff", "server" } },
			},
		},
	},
	{
		"jim-at-jibba/micropython.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
		config = function()
			require("micropython_nvim").setup()
		end,
	},
}
