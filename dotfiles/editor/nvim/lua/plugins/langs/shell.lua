-- lua/plugins/langs/shell.lua
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "bashls" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "bash", "zsh" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "shellcheck", "shfmt" },
    },
  },
}
