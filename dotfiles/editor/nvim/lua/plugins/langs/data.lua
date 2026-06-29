return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "json", "yaml", "toml" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = { "jsonls", "yamlls", "taplo" },
    },
  },
}
