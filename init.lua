vim.g.nvim_start_time = (vim.uv or vim.loop).hrtime()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.lazy")
