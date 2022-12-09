local set = vim.opt
local cmd = vim.cmd
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.smarttab = true
set.textwidth = 78
set.colorcolumn = { "+1", "+2", "+3" }

set.incsearch = true
set.ignorecase = true
set.smartcase = true

set.splitbelow = true
set.splitright = true
set.wrap = false
set.scrolloff = 5
set.fileencoding = "utf-8"
set.termguicolors = true
set.mouse = "a"

set.number = true
set.numberwidth = 5
set.cursorline = true

set.listchars = { eol = "⏎", tab = "␉·", trail = "␠", nbsp = "⎵" }
set.list = true

set.hidden = true

set.background = "dark"

set.cmdheight = 2

--set.conceallevel=3
vim.g["pandoc#syntax#conceal#urls"] = 1
