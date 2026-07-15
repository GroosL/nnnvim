vim.pack.add({
  'https://github.com/mofiqul/dracula.nvim',
  'https://github.com/nvim-mini/mini.pick',
  'https://github.com/nvim-mini/mini.indentscope',
  'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/rafamadriz/friendly-snippets',
	'https://github.com/nvim-mini/mini.statusline',
	'https://github.com/nvim-mini/mini.pairs',
	'https://github.com/nvim-mini/mini-git',
	'https://github.com/nvim-mini/mini.diff',
	'https://github.com/nvim-mini/mini.tabline',
	'https://github.com/nvim-mini/mini.completion',
	'https://github.com/nvim-mini/mini.snippets',
})

require('mini.completion').setup()
require('mini.snippets').setup({
	snippets = {
		require('mini.snippets').gen_loader.from_lang(),
	}
})
MiniSnippets.start_lsp_server()
require('mini.pick').setup()
require('mini.indentscope').setup()
require('mini.pairs').setup()
require('mini.statusline').setup()
require('mini.git').setup()
require('mini.diff').setup()
require('mini.tabline').setup()

local servers = {
  "html",
  "cssls",
  "clangd",
  "nixd",
  "jedi_language_server",
  "gopls"
}
vim.lsp.config('clangd', {
  cmd = {"clangd", "--background-index", "--clang-tidy", "--header-insertion=never"}
})
vim.lsp.enable(servers)
