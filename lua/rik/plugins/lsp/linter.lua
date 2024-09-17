return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			lua = { "luacheck" },
			python = { "flake8" },
			--rust = { "cargo" },
			-- cpp = { "clang-tidy" },
			-- c = { "clang-tidy" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Corrected key mapping setup
		vim.api.nvim_set_keymap(
			"n",
			"<leader>mn",
			':lua require("lint").try_lint()<CR>',
			{ noremap = true, silent = true }
		)
	end,
}
