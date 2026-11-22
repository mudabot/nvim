local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " " }
opt.guicursor = {
  "n-v-c:block-Cursor/lCursor",
  "i-ci:ver25-Cursor/lCursor",
  "r-cr:hor20-Cursor/lCursor",
}

-- Behaviour
opt.mouse = "a"
opt.clipboard = "unnamedplus" -- needs xclip / wl-clipboard on Linux
opt.confirm = true
opt.hidden = true
opt.splitright = true
opt.splitbelow = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = "menu,menuone,noselect"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Indentation (2 spaces everywhere; was the effective value before)
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.breakindent = true

-- Undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
