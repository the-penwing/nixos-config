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
      nls.builtins.diagnostics.pylint,
      -- Lua
      nls.builtins.diagnostics.selene,
      -- Markdown
      nls.builtins.diagnostics.markdownlint,
      -- YAML
      nls.builtins.diagnostics.yamllint,
      -- JSON
      nls.builtins.formatting.prettier.with {
        filetypes = { "json" },
      },
    })
  end,
}
