-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load options first
require("config.options")

-- Apply transparency whenever a colorscheme loads.
-- Must be registered BEFORE lazy.setup, otherwise the startup colorscheme is missed.
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
  end,
})

-- Set up lazy.nvim
require("lazy").setup({
  { import = "plugins" },
}, {
  defaults = {
    lazy = true,
  },

  install = {
    colorscheme = { "catppuccin" },
  },

  checker = {
    enabled = true,
    notify = false,
  },

  rocks = {
    enabled = false
  },

  change_detection = {
    notify = false,
  },

  ui = {
    border = "rounded",
  },
})

-- Load keymaps AFTER lazy.setup so they override plugin defaults
require("config.keymaps")
