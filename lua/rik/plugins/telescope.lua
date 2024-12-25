return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          n = {
            ["q"] = actions.close,
            ["d"] = function(prompt_bufnr)
              local current_buffer = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
              local buffer_id = current_buffer.bufnr
              if buffer_id then
                local clients = vim.lsp.get_clients({bufnr = buffer_id})[1]

                for _,client in ipairs(clients) do
                  vim.lsp.buf_detach_client(buffer_id, client)
                end
                vim.api.nvim_buf_delete(buffer_id, { force = true })
                actions.close(prompt_bufnr)
                vim.cmd("Telescope buffers")
              end
            end
          },
        },
      },
    })
    telescope.load_extension("fzf")

    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find buffers" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers initial_mode=normal<cr>", { desc = "Fuzzy find buffers" })
  end,
}
