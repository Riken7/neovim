vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i","jk","<ESC>", {desc = "Exit insert mode with jk"}) --how it works : in I(nsert) mode when "jk" is press it will escape Insert mode
keymap.set("n","<Esc>",":nohl<CR>",{desc = "Clear search highlights"})
keymap.set("i","<C-Up>","<ESC>kA")
keymap.set("i","<C-Down>","<ESC>jA")

--window management
keymap.set("n","<leader>sv", "<C-w>v", {desc = "split window vertically"})
keymap.set("n","<leader>sh" , "<C-w>s" , {desc = "split window horizontally"})
keymap.set("n","<leader>se" , "<C-w>=", {desc = "map split equal parts"})
keymap.set("n","<leader>sx" , "<cmd>close<CR>" , {desc = "Close current split" })
keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
--tab management
keymap.set("n","<leader>to" , "<cmd>tabnew<CR>" , {desc = "open new tab"})
keymap.set("n","<leader>tx", "<cmd>tabclose<CR>", {desc = "close tab"} )
keymap.set("n","<leader>t]","<cmd>tabn<CR>" , {desc = "go to next tab" })
keymap.set("n","<leader>t[" , "<cmd>tabp<CR>" , {desc = "go to previous tab"})
keymap.set("n","<leader>tn" , "<cmd>tabnew %<CR>", {desc = "open current buffer in new tab" })

--keymap.set('n', '<leader>xx', ':qa!<CR>', { noremap = true, silent = true, desc = 'Close all open files' })
--auto brackets
keymap.set("i","\"","\"\"<left>",{desc = "auto"})
keymap.set("i","\'","\'\'<left>",{desc = "auto"})
keymap.set("i","{","{}<left>",{desc = "auto complete brackets"})
keymap.set("i","(","()<left>",{desc = "auto complete brackets"})
keymap.set("i","[","[]<left>",{desc = "auto complete brackets"})

keymap.set("i", "<C-H>", "<C-w>")

keymap.set("v", "<C-down>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<C-up>", ":m '<-2<CR>gv=gv")

--replace word
keymap.set(
    "n",
    "<leader>rw",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left>]],
    { desc = "Search and replace current word under cursor in current file" }
)

keymap.set("n", "<C-a>", "gg0VG$")
keymap.set("i", "<C-a>", "<ESC>gg0VG$")

keymap.set("n", "<leader>xt", "<cmd>Telescope colorscheme<cr>", {noremap = true , silent = true, desc = "select themes"})

keymap.set("n", "<C-n>" , "<cmd>bnext<cr>" , {desc = "next buffer"})
keymap.set("n", "<C-p>" , "<cmd>bprev<cr>" , {desc = "previous buffer"})
