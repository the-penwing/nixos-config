return {
	"mrcjkb/rustaceanvim",
	version = "^9",
	lazy = false,
	init = function()
		vim.g.rustaceanvim = {
			server = {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
				standalone = false,
				default_settings = {
					["rust-analyzer"] = {
						cargo = {
							buildScripts = { enable = true },
							extraEnv = { CARGO_NET_OFFLINE = "true" },
						},
						checkOnSave = true,
						check = { command = "clippy" },
						files = {
							excludeDirs = { "target", ".git", "node_modules" },
						},
					},
				},
			},
			tools = {
				notifications = { enabled = true },
				notifications = { enabled = false },
			},
		}
	end,
}
