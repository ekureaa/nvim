local languages = {
  "bash",
  "css",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "vue",
  "yaml",
  "zig",
}

local filetypes = {
  "bash",
  "css",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "lua",
  "markdown",
  "python",
  "query",
  "toml",
  "typescript",
  "typescriptreact",
  "vim",
  "vimdoc",
  "vue",
  "yaml",
  "zig",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      require("nvim-treesitter").install(languages)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function(args)
          local ok = pcall(vim.treesitter.start, args.buf)

          if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo.foldmethod = "expr"
            vim.wo.foldlevel = 99
          end
        end,
      })

      vim.keymap.set("n", "<leader>ti", "<cmd>InspectTree<cr>", { desc = "Inspect treesitter tree" })
      vim.keymap.set("n", "<leader>tc", "<cmd>Inspect<cr>", { desc = "Inspect highlight capture" })
    end,
  },
}
