vim.g.netrw_banner = 0

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
-- vim.opt.expandtab = true


vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.inccommand = "split"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 3
vim.opt.showmode = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
-- vim.opt.guicursor = ""
vim.opt.scrolloff = 8

vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

vim.opt.completeopt = { 'menuone', 'noselect', 'fuzzy', 'nosort' }
vim.diagnostic.config({
  virtual_text = true,  -- Shows errors inline next to the code
  signs = false,         -- Shows icons in the gutter (sign column)
  underline = true,     -- Underlines the problematic code
  update_in_insert = false, -- Updates diagnostics while typing
})

-- vim.opt.list = true
-- vim.opt.listchars:append { leadmultispace = "│ ", tab = "│ " }
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "MatchParen", { underline = false, bg = "#555555", fg = "#FFFFFF" })
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.hl.on_yank()
  end,
})
