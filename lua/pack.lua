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

require('mini.completion').setup({
	lsp_completion = {
		-- Adicionamos o parâmetro "base", que é o texto que você digitou (ex: "mov")
		process_items = function(items, base)
			local filtered_items = {}

			for _, item in ipairs(items) do
				-- 1. Toda a sua lógica original de limpeza de dados (mantida idêntica)
				if type(item.labelDetails) ~= 'table' then
					item.labelDetails = nil
				else
					if type(item.labelDetails.detail) ~= 'string' then
						item.labelDetails.detail = nil
					end
					if type(item.labelDetails.description) ~= 'string' then
						item.labelDetails.description = nil
					end
				end
				if type(item.detail) ~= 'string' then
					item.detail = nil
				end
				if type(item.documentation) == 'table' then
					if type(item.documentation.value) ~= 'string' then
						item.documentation.value = nil
					end
				elseif type(item.documentation) ~= 'string' then
					item.documentation = nil
				end

				-- 2. Nova lógica de filtragem:
				-- Só adiciona o item na lista final se ele contiver o que você digitou
				-- Usamos item.filterText ou item.label para fazer a busca
				local text_to_check = item.filterText or item.label or ""
				if string.find(text_to_check:lower(), base:lower(), 1, true) ~= nil then
					table.insert(filtered_items, item)
				end
			end

			-- Retorna apenas os itens que passaram no filtro
			return filtered_items
		end,
	},
})
-- require('mini.completion').setup({
-- 	lsp_completion = {
-- 		process_items = function(items)
-- 			for _, item in ipairs(items) do
-- 				if type(item.labelDetails) ~= 'table' then
-- 					item.labelDetails = nil
-- 				else
-- 					if type(item.labelDetails.detail) ~= 'string' then
-- 						item.labelDetails.detail = nil
-- 					end
-- 					if type(item.labelDetails.description) ~= 'string' then
-- 						item.labelDetails.description = nil
-- 					end
-- 				end
-- 				if type(item.detail) ~= 'string' then
-- 					item.detail = nil
-- 				end
-- 				if type(item.documentation) == 'table' then
-- 					if type(item.documentation.value) ~= 'string' then
-- 						item.documentation.value = nil
-- 					end
-- 				elseif type(item.documentation) ~= 'string' then
-- 					item.documentation = nil
-- 				end
-- 			end
-- 			return items
-- 		end,
-- 	},
-- })
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
  "gopls",
	"glsl_analyzer",
  "asm_lsp"
}
vim.lsp.config('clangd', {
  cmd = {"clangd", "--background-index", "--clang-tidy", "--header-insertion=never"}
})
vim.lsp.config('glsl_analyzer', {
	single_file_support = true,
})
vim.lsp.enable(servers)
