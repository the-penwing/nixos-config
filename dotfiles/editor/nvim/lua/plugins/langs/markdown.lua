-- lua/plugins/langs/markdown.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "markdown" })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "selimacerbas/markdown-preview.nvim",
    dependencies = { "selimacerbas/live-server.nvim" },
    config = function()
      require("markdown_preview").setup {
        instance_mode = "takeover",
        port = 0,
        open_browser = true,
        debounce_ms = 300,
      }
    end,
  },
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown", "rmd" },
    config = function() require("mkdnflow").setup {} end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "markdownlint", "prettier" },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "markdownlint", "prettier" })
    end,
  },
}
