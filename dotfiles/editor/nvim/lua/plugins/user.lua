---@type LazySpec
return {
  {
    "jiaoshijie/undotree",
    opts = {
      -- your options
    },
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>z", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  { import = "astrocommunity.color.transparent-nvim" },
  {
    "editorconfig/editorconfig-vim",
  },
}
