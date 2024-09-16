return {
    "github/copilot.vim",
    config = function()
        vim.keymap.set("n", "<A-d>", ":Copilot disable<CR>", {})
        vim.keymap.set("n", "<A-a>", ":Copilot enable<CR>", {})
        vim.keymap.set("i", "<C-J>", [[copilot#Accept("\<CR>")]], { expr = true, silent = true, noremap = true })
    end,
}
