require("lazy").setup({
	{ import = "plugins" },
	{ import = "langs" },
}, {
	install = { colorscheme = { "dracula" } },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"zipPlugin",
			},
		},
	},
})
