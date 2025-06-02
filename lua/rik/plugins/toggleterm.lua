return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup {
      direction = "float",
      float_opts = {
        border = "rounded",
      },
      open_mapping = [[<leader>tt]],
      insert_mappings = true,
      terminal_mappings = true,
    }
  end
}
