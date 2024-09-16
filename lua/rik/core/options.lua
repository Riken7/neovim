vim.cmd("let g:netrw_liststyle=3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.scrolloff = 15
--tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

--search settings
opt.ignorecase = true
opt.smartcase = true 
opt.cursorline = true

--backspace 
opt.backspace = "indent,eol,start"

--clipboard
opt.clipboard:append("unnamedplus") --use system clipboard

--split window
opt.splitright = true
opt.splitbelow = true

--listchars
--opt.list = true

--opt.listchars = {
--  space = ".",
--  eol = "↴",
--  trail = ".",
--  tab = "┊ ",
--  nbsp = "␣",
--}
