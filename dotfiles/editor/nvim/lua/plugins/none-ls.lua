---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require "null-ls"
    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      -- Customize shfmt to indent case branches
      nls.builtins.formatting.shfmt.with {
        args = { "-i", "2", "--case-indent" },
      },
      -- Python
      nls.builtins.formatting.black,
      -- Lua
      nls.builtins.diagnostics.selene,
      -- YAML
      nls.builtins.diagnostics.yamllint,
      -- JSON
      nls.builtins.formatting.prettier.with {
        filetypes = { "json" },
      },
      -- Swift
      nls.builtins.formatting.swift_format,
      -- Kotlin
      nls.builtins.formatting.ktlint,
      nls.builtins.diagnostics.detekt,
    })
  end,
}
