-- lua/plugins/langs/kotlin.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "kotlin" })
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      lsp = {
        config = {
          kotlin_language_server = {
            root_dir = function(filename)
              local util = require "lspconfig.util"
              return util.root_pattern("build.gradle", "build.gradle.kts", "pom.xml", ".git")(filename)
                or vim.fs.dirname(filename)
            end,
            settings = {
              kotlin = {
                linting = {
                  enabled = true,
                },
              },
            },
          },
        },
      },
    },
  },
}
