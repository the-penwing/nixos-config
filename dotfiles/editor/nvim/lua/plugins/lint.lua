return {
	"mfussenegger/nvim-lint",
	event = { "BufWritePost", "BufReadPost", "InsertLeave" },
	config = function()
		local lint = require("lint")

		local md_linter = lint.linters["markdownlint-cli2"]
		md_linter.args = {
			"--config",
			vim.fn.stdpath("config") .. "/markdownlint.json",
			"--",
		}

		lint.linters_by_ft = {
			markdown = { "markdownlint-cli2" },
			lua = { "selene" },
			kotlin = { "detekt" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
