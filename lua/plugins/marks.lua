return {
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {
      builtin_marks = { ".", "<", ">", "^" },
      default_mappings = true,
      sign_priority = {
        lower = 250,
        upper = 250,
        builtin = 245,
        bookmark = 255,
      },
    },
  },
}
