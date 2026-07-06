return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      rust = { "rustfmt" },
      zig = { "zigfmt" },
      nix = { "alejandra" },
      markdown = { "prettier" },
      lua = {"stylua"},
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2", "-ci" }, -- Add your custom flags here
      },
    },
  },
}
