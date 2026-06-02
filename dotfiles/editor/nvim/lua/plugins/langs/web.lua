-- lua/plugins/langs/web.lua
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "ts_ls", "html", "cssls", "tailwindcss" },
    },
  },
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
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "prettier", "eslint_d" },
    },
  },
}
