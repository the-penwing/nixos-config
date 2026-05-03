return {
  -- CodeCompanion (Chat & Inline) with Ollama + Copilot
  {
    "olimorris/codecompanion.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    config = function()
      -- Model configuration
      local ollama_model = "qwen3.5:2b"

      require("codecompanion").setup({
        display = {
          action_palette = {
            width = 95,
            height = 7,
          },
          chat = {
            window = {
              layout = "vertical",
              width = 0.5,
            },
          },
        },
        strategies = {
          inline = { adapter = "ollama" },
        },
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = { model = { default = ollama_model } },
            })
          end,
        },
      })

      -- Ghost text with Ollama (Ctrl+L)
      vim.keymap.set("i", "<C-l>", function()
        require("codecompanion").inline({
          config = { adapter = "ollama" },
        })
      end, { noremap = true, silent = true, desc = "Ollama inline" })
    end,
  },
}
