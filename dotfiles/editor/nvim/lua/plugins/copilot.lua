---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-a>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<M-d>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      server_opts_overrides = {
        trace = "off",
      },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    opts = {},
  },
}
