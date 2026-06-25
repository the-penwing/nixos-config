-- lua/plugins/langs/c.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "c" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "clang-format" },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "clang-format" })
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
