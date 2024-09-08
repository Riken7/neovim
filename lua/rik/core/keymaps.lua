vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i","jk","<ESC>", {desc = "Exit insert mode with jk"}) --how it works : in I(nsert) mode when "jk" is press it will escape Insert mode
keymap.set("n","<leader>nh",":nohl<CR>",{desc = "Clear search highlights"})

--window management
keymap.set("n","<leader>sv", "<C-w>v", {desc = "split window vertically"})
keymap.set("n","<leader>sh" , "<C-w>s" , {desc = "split window horizontally"})
keymap.set("n","<leader>se" , "<C-w>=", {desc = "map split equal parts"})
keymap.set("n","<leader>sx" , "<cmd>close<CR>" , {desc = "Close current split" })

--tab management
keymap.set("n","<leader>to" , "<cmd>tabnew<CR>" , {desc = "open new tab"})
keymap.set("n","<leader>tx", "<cmd>tabclose<CR>", {desc = "close tab"} )
keymap.set("n","<leader>tn","<cmd>tabn<CR>" , {desc = "go to next tab" })
keymap.set("n","<leader>tp" , "<cmd>tabp<CR>" , {desc = "go to previous tab"})
keymap.set("n","<leader>tf" , "<cmd>tabnew %<CR>", {desc = "open current buffer in new tab" })

--auto brackets
keymap.set("i","\"","\"\"<left>",{desc = "auto"})
keymap.set("i","{","{}<left>",{desc = "auto complete brackets"})
keymap.set("i","(","()<left>",{desc = "auto complete brackets"})
keymap.set("i","[","[]<left>",{desc = "auto complete brackets"})

vim.keymap.set("i", "<C-H>", "<C-w>")


