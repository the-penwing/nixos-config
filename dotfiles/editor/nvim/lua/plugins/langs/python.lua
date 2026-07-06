return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "python" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = { "pyright", "ruff" },
    },
  },
  {
    "jim-at-jibba/micropython.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
    },
    config = function() require("micropython_nvim").setup() end,
  },
}
