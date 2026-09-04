return {
	{
		"AlexandrosAlexiou/kotlin.nvim",
		ft = { "kotlin" },
		dependencies = {
			"mason.nvim",
			"mason-lspconfig.nvim",
			"oil.nvim",
			"trouble.nvim",
		},
		config = function()
			require("kotlin").setup({})
		end,
	},
}
