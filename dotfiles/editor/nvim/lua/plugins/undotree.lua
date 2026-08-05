return {
	"jiaoshijie/undotree",
	dependencies = "nvim-lua/plenary.nvim",
	keys = {
		{ "<leader>z", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle undotree" },
	},
	opts = {},
}
