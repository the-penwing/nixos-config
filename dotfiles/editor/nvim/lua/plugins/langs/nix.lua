-- lua/plugins/langs/nix.lua
return {
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = { "nixd" },
      config = {
        nixd = {
          cmd = { "nixd" },
          filetypes = { "nix" },
          root_markers = { "flake.nix", ".git" },
          settings = {
            nixd = {
              formatting = {
                cmd = { "alejandra" },
                command = { "alejandra" },
              },
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "nix" })
    end,
  },
}
