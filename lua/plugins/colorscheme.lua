return {
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      local set_highlights = function()
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#073642" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#b58900", bg = "#073642", bold = true })
        vim.api.nvim_set_hl(0, "CursorLineSign", { bg = "#073642" })
      end

      vim.o.termguicolors = true
      vim.o.background = "dark"

      require("solarized").setup(opts)
      vim.cmd.colorscheme("solarized")
      set_highlights()

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_highlights,
      })
    end,
  },
}
