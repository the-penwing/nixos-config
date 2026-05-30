return {
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
        -- all optional; sane defaults shown
        instance_mode = "takeover", -- "takeover" (one tab) or "multi" (tab per instance)
        port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
        open_browser = true,
        debounce_ms = 300,
      }
    end,
  },
  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown", "rmd" }, -- Add custom filetypes here if configured
    config = function()
      require("mkdnflow").setup {
        -- Your config
      }
    end,
  },
}
