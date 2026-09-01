-- lua/langs/markdown.lua
return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		opts = {},
	},
	{
		"jakewvincent/mkdnflow.nvim",
		ft = { "markdown", "rmd" },
		opts = {},
	},
	{
		"selimacerbas/markdown-preview.nvim",
		ft = "markdown",
		dependencies = { "selimacerbas/live-server.nvim" },
		opts = {
			instance_mode = "takeover",
			port = 0,
			open_browser = true,
			debounce_ms = 300,
		},
	},
}
