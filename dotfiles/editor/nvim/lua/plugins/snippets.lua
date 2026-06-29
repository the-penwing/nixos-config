-- lua/plugins/snippets.lua (if you don't have one)
return {
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load { paths = "./lua/snippets" }
    end,
  },
}
