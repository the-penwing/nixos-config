return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Register .cherri files as cherri filetype
      vim.filetype.add({
        extension = { cherri = "cherri" },
      })
    end,
  },

  -- Autocomplete for Cherri (pops up automatically)
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Ensure sources exist
      local sources = opts.sources or {}
      table.insert(sources, { name = "buffer" })
      table.insert(sources, { name = "nvim_lsp_signature_help" })

      opts.sources = sources

      -- Auto-trigger completion
      opts.completion = opts.completion or {}
      opts.completion.autocomplete = {
        cmp.TriggerEvent.InsertEnter,
        cmp.TriggerEvent.TextChanged,
      }

      -- Use Tab to filter/select
      opts.mapping = opts.mapping or {}
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { "i", "s" })

      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" })

      opts.mapping["<CR>"] = cmp.mapping.confirm({ select = true })
    end,
  },

  -- Snippets for Cherri keywords
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      -- Cherri snippets
      ls.add_snippets("cherri", {
        s("if", {
          t("if "),
          i(1, "condition"),
          t({ " {", "\t" }),
          i(2),
          t({ "", "}" }),
        }),
        s("repeat", {
          t("repeat "),
          i(1, "count"),
          t({ " {", "\t" }),
          i(2),
          t({ "", "}" }),
        }),
        s("menu", {
          t("menu "),
          i(1, "title"),
          t({ " {", "\t" }),
          i(2),
          t({ "", "}" }),
        }),
        s("func", {
          t("function "),
          i(1, "name"),
          t({ "() {", "\t" }),
          i(2),
          t({ "", "}" }),
        }),
      })
    end,
  },
}
