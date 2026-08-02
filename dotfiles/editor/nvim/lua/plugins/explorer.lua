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
}
