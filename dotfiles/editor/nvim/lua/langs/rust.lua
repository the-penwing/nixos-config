return {
	"mrcjkb/rustaceanvim",
	version = "^9",
	ft = { "rust" },
	init = function()
		vim.g.rustaceanvim = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local has_blink, blink = pcall(require, "blink.cmp")
			if has_blink then
				capabilities = blink.get_lsp_capabilities(capabilities)
			end

			return {
				server = {
					capabilities = capabilities,
					standalone = false,
					default_settings = {
						["rust-analyzer"] = {
							checkOnSave = true,
							check = {
								command = "check",
							},
							cargo = {
								buildScripts = { enable = true },
								extraEnv = { CARGO_NET_OFFLINE = "true" },
							},
							procMacro = { enable = true },
							files = {
								excludeDirs = { "target", ".git", "node_modules" },
							},
						},
					},
				},
				tools = {
					notifications = { enabled = true },
				},
			}
		end
	end,
}
