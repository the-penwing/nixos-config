return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then table.insert(opts.ensure_installed, "asm") end
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      ensure_installed = {},
      servers = { "asm_lsp" },
      config = {
        asm_lsp = {
          cmd = { "asm-lsp" },
          filetypes = { "asm", "s", "S", "vmasm" },
          single_file_support = true,
        },
      },
    },
  },
}
