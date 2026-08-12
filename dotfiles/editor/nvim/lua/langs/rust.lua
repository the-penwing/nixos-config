return {
	{
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
								checkOnSave = false,
								diagnostics = { enable = false },
								cargo = {
									buildScripts = { enable = true },
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
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				bacon_ls = {
					cmd = { "bacon-ls" },
					filetypes = { "rust" },
					root_markers = { "Cargo.toml" },
					settings = {
						bacon_ls = {
							backend = "cargo",
							cargo = {
								command = "clippy",
								checkOnSave = true,
							},
						},
					},
				},
			},
		},
	},
}
