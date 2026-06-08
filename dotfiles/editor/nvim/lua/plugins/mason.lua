-- lua/plugins/mason.lua
-- Comprehensive Mason tool installer matching langs/ directory structure

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- Language Servers (these handle their own diagnostics)
        "lua-language-server",
        "rust-analyzer",
        "python-lsp-server",
        "bash-language-server",
        "marksman",
        "clangd",
        "rnix-lsp",
        "html-lsp",
        "typescript-language-server",
        "yaml-language-server",

        -- Formatters only
        "stylua",
        "black",
        "shfmt",
        "prettier",
        "nixfmt",
        "clang-format",

        -- Debuggers
        "debugpy",
        "codelldb",

        -- Tree-sitter
        "tree-sitter-cli",
      },
    },
  },
}
