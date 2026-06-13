-- lua/plugins/langs/rust.lua
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "rust-analyzer" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "rust" })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
  },
  -- {
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "rust-analyzer" })
  --   end,
  -- },
}
