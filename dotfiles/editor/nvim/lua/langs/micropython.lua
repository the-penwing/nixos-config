-- lua/langs/python.lua
return {
	{
		"jim-at-jibba/micropython.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
		config = function()
			require("micropython_nvim").setup()
		end,
	},
}
