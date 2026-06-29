-- lua/plugins/lint.lua
local plugin = {
  "mfussenegger/nvim-lint",
}

function plugin.config()
  local lint = require "lint"

  -- Safely get the existing linter definition or create a fallback
  local md_linter = lint.linters["markdownlint-cli2"] or {}

  -- Set the command (usually just the binary name)
  md_linter.cmd = md_linter.cmd or "markdownlint-cli2"

  -- Inject our custom config args explicitly
  md_linter.args = {
    "--config",
    vim.fn.expand "~/.config/nvim/markdownlint.json",
    "--",
  }

  -- Assign it back
  lint.linters["markdownlint-cli2"] = md_linter

  lint.linters_by_ft = {
    markdown = { "markdownlint-cli2" },
  }

  -- Automatically run linting across all files
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
    callback = function() lint.try_lint() end,
  })
end

return plugin
