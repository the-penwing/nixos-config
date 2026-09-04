-- lua/plugins/explorer.lua
return {
	{
		"nvim-mini/mini.files",
		version = false,
		opts = {},
		keys = {
			{
				"<leader>e",
				function()
					require("mini.files").open()
				end,
				desc = "Open file explorer",
			},
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = false,
		},
		keys = {
			{
				"<leader>E",
				"<cmd>Oil<cr>",
				desc = "Open Oil",
			},
		},
		dependencies = {
			"nvim-mini/mini.icons",
		},
		lazy = false,
	},
}
