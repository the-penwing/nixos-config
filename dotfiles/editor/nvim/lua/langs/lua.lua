return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			lua_ls = {
				cmd = { "lua-language-server" },
				settings = {
					Lua = {
						runtime = { version = "Lua 5.4" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
					},
				},
			},
		},
	},
}
