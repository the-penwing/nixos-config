-- lua/plugins/blink.lua
return {
  {
    "Saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources = {
        default = { "lsp" }, -- Purely rely on your isolated Lua 5.5 LSP server
        providers = {
          buffer = { enabled = false }, -- Blocks scraping other Neovim file words
          snippets = { enabled = false }, -- Blocks global boilerplate clutter
        },
      }
    end,
  },
}
