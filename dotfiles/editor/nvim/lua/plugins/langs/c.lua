return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "c" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = { "clangd" },
      config = {
        clangd = {
          cmd = { "/run/current-system/sw/bin/clangd" },
        },
      },
    },
  },
}
