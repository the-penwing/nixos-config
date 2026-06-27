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
            },
          },
        },
        nil_ls = {
          cmd = { "nil" },
          filetypes = { "nix" },
          settings = {
            ["nil"] = {
              nix = {
                flake = {
                  autoEvalInputs = false,
                  autoArchive = true,
                },
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
