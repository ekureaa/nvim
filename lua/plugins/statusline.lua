return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      local colors = {
        base03 = "#002b36",
        base02 = "#073642",
        base01 = "#586e75",
        base0 = "#839496",
        base1 = "#93a1a1",
        base2 = "#eee8d5",
        yellow = "#b58900",
        red = "#dc322f",
        magenta = "#d33682",
        violet = "#6c71c4",
        blue = "#268bd2",
        cyan = "#2aa198",
        green = "#859900",
      }

      local theme = {
        normal = {
          a = { fg = colors.base03, bg = colors.blue, gui = "bold" },
          b = { fg = colors.base1, bg = colors.base02 },
          c = { fg = colors.base0, bg = colors.base03 },
        },
        insert = {
          a = { fg = colors.base03, bg = colors.green, gui = "bold" },
          b = { fg = colors.base1, bg = colors.base02 },
          c = { fg = colors.base0, bg = colors.base03 },
        },
        visual = {
          a = { fg = colors.base03, bg = colors.magenta, gui = "bold" },
          b = { fg = colors.base1, bg = colors.base02 },
          c = { fg = colors.base0, bg = colors.base03 },
        },
        replace = {
          a = { fg = colors.base03, bg = colors.red, gui = "bold" },
          b = { fg = colors.base1, bg = colors.base02 },
          c = { fg = colors.base0, bg = colors.base03 },
        },
        command = {
          a = { fg = colors.base03, bg = colors.yellow, gui = "bold" },
          b = { fg = colors.base1, bg = colors.base02 },
          c = { fg = colors.base0, bg = colors.base03 },
        },
        inactive = {
          a = { fg = colors.base01, bg = colors.base03 },
          b = { fg = colors.base01, bg = colors.base03 },
          c = { fg = colors.base01, bg = colors.base03 },
        },
      }

      return {
        options = {
          theme = theme,
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "dashboard", "lazy", "mason" },
          },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(mode)
                return " " .. mode
              end,
            },
          },
          lualine_b = {
            {
              "branch",
              icon = "",
            },
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
              diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.yellow },
                removed = { fg = colors.red },
              },
            },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
              symbols = {
                modified = " ●",
                readonly = " ",
                unnamed = "[No Name]",
                newfile = "[New]",
              },
              color = { fg = colors.base2, gui = "bold" },
            },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
              },
              diagnostics_color = {
                error = { fg = colors.red },
                warn = { fg = colors.yellow },
                info = { fg = colors.blue },
                hint = { fg = colors.cyan },
              },
            },
            {
              "searchcount",
              color = { fg = colors.yellow },
            },
            {
              "selectioncount",
              color = { fg = colors.violet },
            },
            {
              "encoding",
              fmt = string.upper,
              color = { fg = colors.base1 },
            },
            {
              "fileformat",
              symbols = {
                unix = "",
                dos = "",
                mac = "",
              },
            },
            {
              "filetype",
              colored = true,
              icon_only = false,
            },
          },
          lualine_y = {
            {
              "progress",
              color = { fg = colors.cyan, gui = "bold" },
            },
          },
          lualine_z = {
            {
              "location",
              icon = "",
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = {
          "lazy",
          "mason",
        },
      }
    end,
  },
}
