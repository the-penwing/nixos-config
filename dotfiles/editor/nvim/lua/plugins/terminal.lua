return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal", mode = { "n", "t" } },
	},
	opts = {
		direction = "float",
		float_opts = {
			border = "curved",
		},
	},
}
