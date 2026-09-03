local map = vim.keymap.set

vim.g.mapleader = " "

-- Save, exit
map("n", "zz", ":w<cr>")
map("n", "zx", ":wq<cr>")
map("n", "zc", ":q!<cr>")

map("n", "<leader>re", ":restart<cr>")

local function live_search()
  local MiniPick = require('mini.pick')
  local cwd = vim.fn.getcwd()
  local set_items_opts = { do_match = false }
  local sys = { kill = function() end }

  local match = function(_, _, query)
    sys:kill()
    local prompt = table.concat(query)
    set_items_opts.querytick = MiniPick.get_querytick()

    local command = {
      'search',
      '.',
      prompt,
      '-s',
      '-r',
      '-i', '.git',
      '-i', 'node_modules',
      '-i', 'target',
    }

    sys = MiniPick.set_picker_items_from_cli(command, {
      set_items_opts = set_items_opts,
      spawn_opts = { cwd = cwd },
      postprocess = function(lines)
        local res = {}
        for _, line in ipairs(lines) do
          if line ~= '' then
            table.insert(res, (line:gsub('^%./', '')))
          end
        end
        return res
      end,
    })
  end

  MiniPick.start({
    source = {
      name = 'Search (GESearch)',
      cwd = cwd,
      items = {},
      match = match,
      show = function(buf_id, items, query)
        MiniPick.default_show(buf_id, items, query, { show_icons = true })
      end,
    },
  })
end

vim.schedule(function()
  local ok, MiniPick = pcall(require, 'mini.pick')
  if ok and MiniPick.registry then
    MiniPick.registry.search = live_search
  end
end)

map('n', '<leader>e', live_search, { desc = "Live search files with GESearch" })
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
    vim.cmd("15split | term exec $(echo $SHELL)")
    vim.cmd("startinsert")
  end
end, { desc = "Toggle/Reveal hidden terminal" })
map('t', '<Esc>', [[<C-\><C-n>:hide<CR>]], { desc = "Hide terminal window" })

map("n", "H", ":noh<cr>")
map("n", "<leader>C", ":bd!<cr>")

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
