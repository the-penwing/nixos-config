-- lua/plugins/lint.lua
local plugin = {
  "mfussenegger/nvim-lint",
}

function plugin.config()
  local lint = require "lint"
  
  -- Markdown configuration
  local md_linter = lint.linters["markdownlint-cli2"] or {}
  md_linter.cmd = md_linter.cmd or "markdownlint-cli2"
  md_linter.args = {
    "--config",
    vim.fn.expand "~/.config/nvim/markdownlint.json",
    "--",
  }
  lint.linters["markdownlint-cli2"] = md_linter
  
  -- Force native system selene to use your global config file
  local selene = lint.linters.selene or {}
  selene.args = {
    "--config",
    vim.fn.expand "~/.config/nvim/selene.toml",
    "--formatter",
    "json",
  }
  lint.linters.selene = selene

  -- Assign linters to filetypes
  lint.linters_by_ft = {
    markdown = { "markdownlint-cli2" },
    lua = { "selene" },
    kotlin = {"detekt"}
  }
  
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
    callback = function() lint.try_lint() end,
  })
end

return plugin
