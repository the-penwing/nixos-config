return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	opts = {
		servers = {},
	},
	config = function(_, opts)
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		for server, cfg in pairs(opts.servers) do
			cfg.capabilities = vim.tbl_deep_extend("force", capabilities, cfg.capabilities or {})
			vim.lsp.config(server, cfg)
			vim.lsp.enable(server)
		end
	end,
}
