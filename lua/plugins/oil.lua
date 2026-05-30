return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "<leader>e", "<cmd>Oil<cr>", desc = "Open file explorer" },
    },
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,
      keymaps = {
        ["l"] = "actions.select",
        ["h"] = { "actions.parent", mode = "n" },
      },
      view_options = {
        show_hidden = true,
        natural_order = "fast",
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      float = {
        border = "rounded",
        padding = 2,
      },
      confirmation = {
        border = "rounded",
      },
      progress = {
        border = "rounded",
      },
      keymaps_help = {
        border = "rounded",
      },
    },
  },
}
