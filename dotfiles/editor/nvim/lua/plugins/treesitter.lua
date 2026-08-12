return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local langs = {
			"lua",
			"vim",
			"vimdoc",
			"c",
			"nix",
			"rust",
			"python",
			"kotlin",
			"zig",
			"asm",
			"json",
			"yaml",
			"toml",
			"markdown",
			"markdown_inline",
			"html",
			"css",
			"javascript",
			"typescript",
			"slint",
			"tsx",
			"bash",
			"swift",
		}
		require("nvim-treesitter").install(langs)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = langs,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
