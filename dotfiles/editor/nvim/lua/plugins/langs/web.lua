-- lua/plugins/langs/web.lua
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "typescript-language-server", "html-lsp", "css-lsp", "tailwindcss-language-server" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        { "html-lsp", "css", "javascript", "typescript", "tsx" }
      )
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "prettier", "eslint_d" },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        { "typescript-language-server", "html-lsp", "css-lsp", "tailwindcss-language-server", "prettier", "eslint_d" }
      )
    end,
  },
}
