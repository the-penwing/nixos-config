-- lua/plugins/langs/nix.lua
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      servers = { "nixd" },
      config = {
        nixd = {
          cmd = { "nixd" },
          filetypes = { "nix" },
          root_markers = { "flake.nix", ".git" },
          settings = {
            nixd = {
              installables = {
                nixpkgs = {
                  expr = [[import (let flake = builtins.getFlake "/home/benvl/nixos-config"; in if flake ? inputs then flake.inputs.nixpkgs else <nixpkgs>) { }]],
                },
              },
              options = {
                nixos = {
                  expr = [[(builtins.getFlake "/home/benvl/nixos-config").nixosConfigurations."nixos-p14s".options]],
                },
                ["home-manager"] = {
                  expr = [[(builtins.getFlake "/home/benvl/nixos-config").homeConfigurations."benvl".options]],
                },
              },
              nixpkgs = {
                expr = [[import (let flake = builtins.getFlake "/home/benvl/nixos-config"; in if flake ? inputs then flake.inputs.nixpkgs else <nixpkgs>) { }]],
              },
              formatting = {
                command = { "alejandra" },
              },
              -- KEY: This is in 2.9.1+
              diagnostic = {
                suppress = { "EvalError" }, -- Don't crash on eval errors
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
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "alejandra" })
    end,
  },
}
