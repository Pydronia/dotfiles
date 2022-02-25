-- Automatically install packer if it isn"t already
local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	print("Installing Packer... Please restart nvim and run :PackerSync")
	packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

-- autocommand to PackerCompile whenever plugins.lua is saved
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

-- Simple function to return the require for configuring plugins
function getSetup(name)
	return string.format("require('config/%s')", name)
end

-- Packer setup and plugin list
require("packer").startup({function()
	use "wbthomason/packer.nvim"

	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = getSetup("treesitter") }
	use { "ishan9299/nvim-solarized-lua", config = getSetup("colorscheme") }

	use {
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = getSetup("cmp")
	}

	use { "neovim/nvim-lspconfig", requires = "hrsh7th/cmp-nvim-lsp", config = getSetup("lsp") }

	-- Automatically set up configuration after cloning packer.nvim
	if packer_bootstrap then
		require("packer").sync()
	end
end,
config = {
	display = {
		open_fn = require("packer.util").float,
	},
}})
