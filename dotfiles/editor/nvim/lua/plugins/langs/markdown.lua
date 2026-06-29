-- lua/plugins/langs/markdown.lua
return {
  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "markdown", "markdown_inline" })
    end,
  },

  -- UI Rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  -- Live Preview
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

  -- Navigation & Links
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown", "rmd" },
    config = function() require("mkdnflow").setup {} end,
  },

  -- Native LSP Registration (AstroNvim Base)
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.lsp = opts.lsp or {}
      opts.lsp.servers = opts.lsp.servers or {}
      opts.lsp.servers = require("astrocore").list_insert_unique(opts.lsp.servers, { "marksman" })
    end,
  },
}
