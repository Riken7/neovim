return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim",                   opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    --    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Autocompletion capabilities
    --local capabilities = cmp_nvim_lsp.default_capabilities()
    -- Diagnostic symbols
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    lspconfig.nixd.setup({
      cmd = { "nixd" },
      capabilities = cmp_nvim_lsp.default_capabilities(),
      filetypes = { "nix" },
    })
    local lua_ls_path = "/etc/profiles/per-user/rik/bin/lua-language-server"
    lspconfig.lua_ls.setup({
      cmd = { lua_ls_path },
      capabilities = cmp_nvim_lsp.default_capabilities(),
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          format = {
            enable = true,
          },
        },
      },
    })
    local jdtls_path = "/etc/profiles/per-user/rik/bin/jdtls"
    lspconfig.jdtls.setup({
      cmd = { jdtls_path },
      root_dir = function(fname)
        local root_patterns = { ".git", "gradlew", "mvnw" }
        local found = vim.fs.find(root_patterns, { upward = true })
        if #found > 0 then
          return vim.fs.dirname(found[1])
        else
          return vim.fs.dirname(fname)
        end
      end,
      capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities({
          workspace = {
            configuration = true,
          },
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
              },
            },
          },
        })
      ),
      settings = {
        java = {
          signatureHelp = { enabled = true },
          formatting = {
            enable = true,
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
            },
            generateComments = true,
            insertPackage = true,
          },
        },
      },
    })
    local clangd_path = "/etc/profiles/per-user/rik/bin/ccls"
    lspconfig.ccls.setup({
      cmd = { clangd_path },
      capabilities = cmp_nvim_lsp.default_capabilities(),
      filetypes = { "c", "cpp", "objc", "objcpp" },
    })

    local rust_path = "/etc/profiles/per-user/rik/bin/rust-analyzer"
    lspconfig.rust_analyzer.setup({
      on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end,
      cmd = { rust_path },
      capabilities = cmp_nvim_lsp.default_capabilities(),
      filetypes = { "rust" },
      root_dir = lspconfig.util.root_pattern("Cargo.toml", ".git"),
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            buildScripts = { enable = true },
            allFeatures = true,
            loadOutDirsFromCheck = true,
          },
          imports = {
            granularity = { group = "module" },
          },
          procMacro = { enable = true },
          diagnostics = {
            enable = true
          },
          checkOnSave = {
            enable = true,
            command = "clippy",
          },
          completion = { autoImport = { enable = true } },
        },
      },
    })
    local ts_path = "/etc/profiles/per-user/rik/bin/typescript-language-server"
    lspconfig.ts_ls.setup({
      cmd = { ts_path, "--stdio" },
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", ".git"),
      capabilities = cmp_nvim_lsp.default_capabilities(),
    })
    lspconfig.pyright.setup({
      capabilities = cmp_nvim_lsp.default_capabilities(),
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "strict", -- Customize this as needed
          },
        },
      },
    })
    local tailwindcss_path =
    "/etc/profiles/per-user/rik/bin/tailwindcss-language-server"
    lspconfig.tailwindcss.setup({
      cmd = { tailwindcss_path, "--stdio" },
      filetypes = { "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
      capabilities = cmp_nvim_lsp.default_capabilities(),
    })
    local vscode_langserver_path = "/etc/profiles/per-user/rik/bin/vscode-html-language-server"
    lspconfig.html.setup({
      cmd = { vscode_langserver_path, "--stdio" },
      capabilities = cmp_nvim_lsp.default_capabilities(),
      filetypes = { "html" },
      provideFormatter = true,
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
      on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")

          vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", {
            noremap = true,
            silent = true,
          })
        end
        end
    })
  end,
}
