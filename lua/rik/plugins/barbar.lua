return {
  {
    "romgrk/barbar.nvim",
    priority = 1000,
    config = function()
      vim.g.barbar_auto_setup = false -- disable auto-setup

      require("barbar").setup({
        animation = false,

        -- Enable/disable current/total tabpages indicator (top right corner)
        tabpages = true,

        -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
        -- Valid options are 'left' (the default), 'previous', and 'right'
        focus_on_close = 'left',

        -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
        hide = { extensions = false, inactive = false },

        icons = {
          buffer_index = false,
          buffer_number = false,
          button = '',
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
          },
          gitsigns = {
            added = { enabled = true, icon = ' ' },
            changed = { enabled = true, icon = ' ' },
            deleted = { enabled = true, icon = ' ' },
          },
          separator = { left = '▎', right = '' },

          -- If true, add an additional separator at the end of the buffer list
          separator_at_end = true,

          -- Configure the icons on the bufferline when modified or pinned.
          modified = { button = '●' },
          pinned = { button = '', filename = true },

          -- Configure the icons on the bufferline based on the visibility of a buffer.
          alternate = { filetype = { enabled = false } },
          current = { buffer_index = true },
          inactive = { button = '×' },
          visible = { modified = { buffer_number = false } },
        },

        sidebar_filetypes = {
          NvimTree = true,
          undotree = {
            text = 'undotree',
            align = 'left',
          },
          ['neo-tree'] = { event = 'BufWipeout' },
          Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
        },
        
        maximum_length = 25, -- Sets the maximum buffer name length.
      })
    end
  },
}
