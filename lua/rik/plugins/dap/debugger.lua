return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    -- Automatically open and close the UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Key mappings
    local opts = { noremap = true, silent = true, desc = "Debugging" }
    vim.keymap.set("n", "<F5>", function() dap.continue() end, opts)
    vim.keymap.set("n", "<F10>", function() dap.step_over() end, opts)
    vim.keymap.set("n", "<F11>", function() dap.step_into() end, opts)
    vim.keymap.set("n", "<F12>", function() dap.step_out() end, opts)
    vim.keymap.set("n", "<leader>bb", function() dap.toggle_breakpoint() end, opts)
    vim.keymap.set("n", "<leader>bi", function() dapui.toggle() end, opts)
  end,
}
