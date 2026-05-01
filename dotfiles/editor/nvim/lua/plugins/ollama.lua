return {
  -- 1. CodeCompanion (Chat & Inline)
  {
    "olimorris/codecompanion.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = { adapter = "ollama" },
          inline = { adapter = "ollama_fast" },
        },
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = { model = { default = "qwen3.5:9b" } },
            })
          end,
          ollama_fast = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = { model = { default = "qwen3.5:2b" } },
            })
          end,
        },
      })
    end,
  },

  -- 2. Autocomplete Integration (The Fix for your error)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "tzachar/cmp-ai",
        config = function()
          require("cmp_ai.config"):setup({
            max_lines = 100,
            provider = "Ollama",
            provider_options = { model = "qwen3.5:2b" },
            notify = false,
          })
        end,
      },
    },
    opts = function(_, opts)
      -- This adds cmp-ai to the list of sources
      table.insert(opts.sources, { name = "cmp_ai" })
      
      -- Enable ghost text (Copilot style)
      opts.experimental = opts.experimental or {}
      opts.experimental.ghost_text = true
    end,
  },
}
