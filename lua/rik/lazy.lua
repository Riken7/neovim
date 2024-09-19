local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.jupyter_kernel_name = 'python3'
require("lazy").setup({ { import = "rik.plugins" }, { import = "rik.plugins.lsp" } },{
  checker = {
    enable = true,
    notify = false,
  },
  change_detection = {notify = false},
})
