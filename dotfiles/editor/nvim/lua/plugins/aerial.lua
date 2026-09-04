return {
	{
		"stevearc/aerial.nvim",
		opts = {
			layout = {
				default_direction = "prefer_right",
			},
		},
		keys = {
			{
				"<leader>s",
				"<cmd>AerialToggle!<cr>",
				desc = "Toggle Aerial",
			},
		},
	},
}
