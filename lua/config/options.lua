vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:2"
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

local is_container = vim.fn.filereadable("/.dockerenv") == 1
  or vim.fn.filereadable("/run/.containerenv") == 1
  or vim.env.REMOTE_CONTAINERS == "true"
  or vim.env.CODESPACES == "true"

if vim.fn.has("wsl") == 1 and vim.fn.executable("clip.exe") == 1 and vim.fn.executable("powershell.exe") == 1 then
  local copy_command = {
    "powershell.exe",
    "-NoLogo",
    "-NoProfile",
    "-Command",
    '[Console]::InputEncoding = [System.Text.UTF8Encoding]::new($false); Set-Clipboard -Value ([Console]::In.ReadToEnd())',
  }
  local paste_command = {
    "powershell.exe",
    "-NoLogo",
    "-NoProfile",
    "-Command",
    '[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false); $clip = Get-Clipboard -Raw; if ($null -ne $clip) { [Console]::Out.Write($clip.Replace("`r", "")) }',
  }

  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = copy_command,
      ["*"] = copy_command,
    },
    paste = {
      ["+"] = paste_command,
      ["*"] = paste_command,
    },
    cache_enabled = 0,
  }

  vim.opt.clipboard = "unnamedplus"
elseif is_container then
  local osc52 = require("vim.ui.clipboard.osc52")
  local copy_to_windows = osc52.copy("+")

  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("container-clipboard", { clear = true }),
    callback = function()
      if vim.v.event.operator == "y" then
        copy_to_windows(vim.v.event.regcontents)
      end
    end,
  })
end
