return {
  -- 1. The Chat/Agent Plugin (CodeCompanion)
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
              schema = { model = { default = "qwen3.5:9b-q4_K_M" } },
            })
          end,
          ollama_fast = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = { model = { default = "qwen3.5:2b-q8_0" } },
            })
          end,
        },
      })
    end,
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI Chat" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "AI Actions" },
    },
  },

  -- 2. The Autocomplete/Ghost Text Plugin (cmp-ai)
  {
    "tzachar/cmp-ai",
    dependencies = "hrsh7th/nvim-cmp",
    config = function()
      local cmp_ai = require("cmp_ai.config")
      cmp_ai:setup({
        max_lines = 100,
        provider = "Ollama",
        provider_options = {
          model = "qwen3.5:2b-q8_0", -- Using your lightning-fast 2B model
        },
        notify = false,
      })
    end,
  },

  -- 3. Integrating it into LazyVim's Completion
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "cmp_ai" })
      
      -- Optional: Styling the ghost text to look like Copilot
      opts.experimental = opts.experimental or {}
      opts.experimental.ghost_text = true
    end,
  },
}
