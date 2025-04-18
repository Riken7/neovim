return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "luaformatter" },
        java = { "google-java-format" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        rust = { "rustfmt" },
        python = { "isort", "black" },
        nix = { "nixfmt" },
        c = { "clang-format" },
        html = { "prettierd" },
      },
      formatter_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 5000,
      })
    end, { desc = "Format file" })
  end,
}
