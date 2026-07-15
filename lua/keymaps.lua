local map = vim.keymap.set

vim.g.mapleader = " "

-- Save, exit
map("n", "zz", ":w<cr>")
map("n", "zx", ":wq<cr>")
map("n", "zc", ":q!<cr>")

map("n", "<leader>re", ":restart<cr>")

vim.keymap.set('n', '<leader>e', function()
  require('mini.pick').builtin.files(nil, { opts = { tool = 'search' } })
end, { desc = "Pick files recursively using Ripgrep" })
map("n", "<leader>E", ":Ex<cr>")

map("n", "rn", ":set relativenumber!<cr>")

-- Compiling and other custom commands
map("n", "<leader>fc", ":!clang-format -i %<cr>")
map("n", "<leader>ca", ":!make<cr>")
map("n", "<leader>cr", ":!make run<cr>")

map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
map("v", "<leader>/", "gc", { remap = true, desc = "Toggle comment selection" })

map('n', '<leader>t', function()
  local term_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      term_buf = buf
      break
    end
  end

  if term_buf then
    vim.cmd("15split")
    vim.api.nvim_win_set_buf(0, term_buf)
    vim.cmd("startinsert")
  else
    vim.cmd("15split | term zsh")
    vim.cmd("startinsert")
  end
end, { desc = "Toggle/Reveal hidden terminal" })
map('t', '<Esc>', [[<C-\><C-n>:hide<CR>]], { desc = "Hide terminal window" })


map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "<", "<gv")
map("v", ">", ">gv")

map("i", "<C-c>", "<Esc>")
map("x", "p", [["_dP]], { desc = "Paste over selection without losing yanked text" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })

map("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })
