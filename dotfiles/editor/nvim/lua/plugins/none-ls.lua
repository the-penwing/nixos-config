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
    })
  end,
}
