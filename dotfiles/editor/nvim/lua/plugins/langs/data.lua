-- lua/plugins/langs/data.lua
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "jsonls", "yamlls", "taplo" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "json", "yaml", "toml" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "prettier", "yamllint" },
    },
  },
}
