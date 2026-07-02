-- lua/plugins/langs/swift.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "swift" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = { "sourcekit" },
      config = {
        sourcekit = {
          cmd = { "sourcekit-lsp" },
          filetypes = { "swift" },
          root_markers = { "Package.swift", ".git" },
        },
      },
    },
  },
}
