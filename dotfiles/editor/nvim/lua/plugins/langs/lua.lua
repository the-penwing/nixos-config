-- lua/plugins/langs/lua.lua
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua-language-server" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "lua" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "stylua" },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "lua-language-server", "stylua" })
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      lsp = {
        config = {
          lua_ls = {
            on_attach = function(client)
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end,
            root_dir = function(filename)
              local util = require "lspconfig.util"
              return util.root_pattern(".git", "init.lua", "selene.toml", "stylua.toml")(filename)
                or vim.fs.dirname(filename)
            end,

            settings = {
              Lua = {
                runtime = {
                  version = "Lua 5.5",
                  pathStrict = true,
                },
                workspace = {
                  checkThirdParty = false,
                  library = {},
                  ignoreDir = {
                    ".git",
                    "node_modules",
                    "build",
                    ".cache",
                    "target",
                    "dist",
                  },
                  maxPreload = 2000,
                  preloadFileSize = 150,
                },
                diagnostics = {
                  enable = true,
                  neededFileStatus = {
                    ["codestyle-check"] = "None",
                  },
                },
                completion = {
                  enable = true,
                  callSnippet = "Replace",
                },
                telemetry = { enable = false },
                codeLens = { enable = false },
                hint = { enable = true },
              },
            },
          },
        },
      },
    },
  },
}
