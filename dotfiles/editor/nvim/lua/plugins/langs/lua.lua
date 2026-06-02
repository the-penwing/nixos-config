-- lua/plugins/langs/lua.lua
return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls" },
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
      ensure_installed = { "stylua", "luacheck" },
    },
  },
}
