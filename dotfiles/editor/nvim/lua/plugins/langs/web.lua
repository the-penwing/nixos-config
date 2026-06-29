return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        { "html", "css", "javascript", "typescript", "tsx" }
      )
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = { "ts_ls", "html", "cssls", "tailwindcss" },
    },
  },
}
