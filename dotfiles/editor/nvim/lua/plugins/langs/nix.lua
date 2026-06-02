-- lua/plugins/langs/nix.lua
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "nil_ls" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "nix" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "nixpkgs-fmt", "statix" },
    },
  },
}
