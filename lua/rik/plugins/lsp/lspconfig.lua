return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
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
				keymap.set("n", "<leader>d", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>D", vim.diagnostic.open_float, opts)

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
		local lua_ls_path =
     "/nix/store/3fp5s0cydnczsh74ylsqni2c3kiapx4s-lua-language-server-3.10.6/bin/lua-language-server" 
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
		local jdtls_path = "/nix/store/smcs8wil4sdwn1lgfpir3yzbnfa6nmrc-jdt-language-server-1.39.0/bin/jdtls"

		lspconfig.jdtls.setup({
			cmd = { jdtls_path, "--add-modules", "java.se", "--add-exports", "java.base/java.lang=ALL-UNNAMED" },
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
				require("cmp_nvim_lsp").default_capabilities()
			),
			filetypes = { "java" },
			settings = {
				java = {
					signatureHelp = { enabled = true },
					contentProvider = { preferred = "fernflower" },
					import = { enabled = true },
					rename = { enabled = true },
				},
			},
		})
		lspconfig.clangd.setup({
			cmd = { clangd_path },
			capabilities = cmp_nvim_lsp.default_capabilities(),
			filetypes = { "c", "cpp", "objc", "objcpp" },
			settings = {
				clangd = {
					--additional settings
				},
			},
		})

		local rust_path = "/nix/store/c9mv63b3xck3kacmfir5dzf408kxjq41-rust-analyzer-2024-08-12/bin/rust-analyzer"
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
					},
					imports = {
						granularity = { group = "module" },
					},
					procMacro = { enable = true },
				},
			},
		})
		local ts_path =
			"/nix/store/rv4pwdwp3axbdip0l4fq0i8sa1caws3k-typescript-language-server-4.3.3/bin/typescript-language-server"
		lspconfig.ts_ls.setup({
			cmd = { ts_path, "--stdio" },
			filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
			root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", ".git"),
			capabilities = cmp_nvim_lsp.default_capabilities(),
			settings = {
				typescript = {
					--additional settings
				},
				javascript = {
					--additional settings
				},
			},
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
		local tailwindcss_path = "/nix/store/fzlkpk5p2w7piqc6vvxvky4zbswc1fms-tailwindcss-language-server-0.0.21/bin/tailwindcss-language-server"
		lspconfig.tailwindcss.setup({
			cmd = { tailwindcss_path, "--stdio" },
			filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			capabilities = cmp_nvim_lsp.default_capabilities(),
		})
	end,
}
