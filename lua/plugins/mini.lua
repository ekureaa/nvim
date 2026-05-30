return {
  {
    "nvim-mini/mini.ai",
    version = "*",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")

      return {
        custom_textobjects = {
          f = ai.gen_spec.function_call(),
          F = ai.gen_spec.function_call({ name_pattern = "[%w_%.:]+%s*" }),
        },
        n_lines = 200,
        search_method = "cover_or_nearest",
      }
    end,
  },
  {
    "nvim-mini/mini.surround",
    version = "*",
    event = "VeryLazy",
    opts = {
      n_lines = 80,
      search_method = "cover_or_nearest",
    },
  },
  {
    "nvim-mini/mini.pairs",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-mini/mini.comment",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvim-mini/mini.diff",
    version = "*",
    event = "VeryLazy",
    opts = {
      view = {
        style = "sign",
        signs = {
          add = "+",
          change = "~",
          delete = "-",
        },
      },
    },
    config = function(_, opts)
      require("mini.diff").setup(opts)

      local diff_line_namespace = vim.api.nvim_create_namespace("mini-diff-line-highlights")

      local set_diff_highlights = function()
        vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { fg = "#859900", bold = true })
        vim.api.nvim_set_hl(0, "MiniDiffSignChange", { fg = "#b58900", bold = true })
        vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { fg = "#dc322f", bold = true })
        vim.api.nvim_set_hl(0, "MiniDiffLineAdd", { bg = "#103b2d" })
        vim.api.nvim_set_hl(0, "MiniDiffLineChange", { bg = "#3d3517" })
        vim.api.nvim_set_hl(0, "MiniDiffLineDelete", { bg = "#3d2024" })
      end

      local refresh_line_highlights = function(buf)
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end

        vim.api.nvim_buf_clear_namespace(buf, diff_line_namespace, 0, -1)

        local ok, data = pcall(MiniDiff.get_buf_data, buf)
        if not ok or data == nil or data.hunks == nil then
          return
        end

        local line_count = vim.api.nvim_buf_line_count(buf)

        for _, hunk in ipairs(data.hunks) do
          local hl_group = ({
            add = "MiniDiffLineAdd",
            change = "MiniDiffLineChange",
            delete = "MiniDiffLineDelete",
          })[hunk.type]

          if hl_group ~= nil then
            local start_line = math.max(hunk.buf_start, 1)
            local count = math.max(hunk.buf_count, 1)
            local end_line = math.min(start_line + count - 1, line_count)

            for line = start_line, end_line do
              vim.api.nvim_buf_set_extmark(buf, diff_line_namespace, line - 1, 0, {
                line_hl_group = hl_group,
                priority = 198,
              })
            end
          end
        end
      end

      set_diff_highlights()

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_diff_highlights,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniDiffUpdated",
        callback = function(args)
          refresh_line_highlights(args.buf)
        end,
      })
    end,
  },
}
