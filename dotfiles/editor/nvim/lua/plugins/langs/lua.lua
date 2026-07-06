-- lua/plugins/langs/lua.lua
local function get_lua_root(bufnr)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  if filename == "" then return nil end

  local util = require "lspconfig.util"
  local pattern = util.root_pattern(".git", "init.lua", "selene.toml", "stylua.toml")(filename)

  if pattern then
    return pattern
  else
    return vim.fs.dirname(filename)
  end
end

return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      servers = {
        "lua_ls",
      },
      handlers = {
        lua_ls = function(server)
          vim.lsp.enable(server)
        end,
      },
      config = {
        lua_ls = {
          cmd = { "lua-language-server" },
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
          root_dir = get_lua_root,
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
                pathStrict = true,
              },
              workspace = {
                checkThirdParty = false,
                library = {},
                inheritedCollection = false,
                maxPreload = 1000,
                preloadFileSize = 150,
              },
              diagnostics = {
                enable = true,
                globals = {},
                neededFileStatus = {
                  ["codestyle-check"] = "None",
                },
              },
              completion = {
                enable = true,
                callSnippet = "Replace",
                workspaceWord = false,
                showWord = "Disable",
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
}
