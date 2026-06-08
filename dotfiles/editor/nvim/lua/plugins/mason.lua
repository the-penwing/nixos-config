-- lua/plugins/mason.lua
-- Comprehensive Mason tool installer matching langs/ directory structure

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- Tree-sitter
        "tree-sitter-cli",
      },
    },
  },
}
