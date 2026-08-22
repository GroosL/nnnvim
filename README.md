# nnnvim

No nonsense Neovim.

A lightweight, fast, and easy-to-configure Neovim starter config built for people who want a clean editor without a lot of ceremony.

## Why nnnvim?

- Blazingly fast startup and minimal overhead
- Small, opinionated plugin set
- Lua-first configuration
- Easy to extend without a giant config tree
- Good defaults for coding and quick editing

## Features

- `mini.*` plugin ecosystem for a lean and modern editing experience
- Fast file picker with `mini.pick`
- Lightweight status, tab, and diff helpers
- LSP support for common languages
- Simple keybindings designed for speed
- Minimal UI clutter and sensible defaults

## Included setup

This config uses:

- Neovim builtin package system via `vim.pack`
- `mini.pick`, `mini.statusline`, `mini.tabline`, `mini.diff`, `mini.git`, `mini.pairs`, `mini.indentscope`, `mini.completion`, `mini.snippets`
- `nvim-lspconfig` for language servers
- Dracula theme

## Quick start

1. Install Neovim.
2. Clone this repo into your Neovim config directory:

```bash
git clone https://github.com/your-name/nnnvim.git ~/.config/nvim
```

3. Launch Neovim:

```bash
nvim
```

4. If you want to refresh plugins:

```bash
nvim --headless "+PackUpdate" +qa
```

## Keybindings

The config ships with a few quick shortcuts:

- `<leader>e` — open file picker
- `<leader>E` — netrw explorer
- `zz` — save
- `zx` — save and quit
- `zc` — close without saving
- `<leader>/` — toggle comments
- `<leader>t` — open or reveal terminal
- `<leader>fc` — format current file with `clang-format`
- `<leader>ca` — run `make`
- `<leader>cr` — run `make run`
- `rn` — toggle relative numbers

## Structure

```text
.
├── init.lua
├── nvim-pack-lock.json
└── lua/
    ├── commands.lua
    ├── keymaps.lua
    ├── options.lua
    └── pack.lua
```

## Customizing

The config is intentionally small and easy to modify:

- Edit [lua/options.lua](lua/options.lua) for editor defaults
- Edit [lua/keymaps.lua](lua/keymaps.lua) for keybindings
- Edit [lua/pack.lua](lua/pack.lua) for plugins
- Edit [lua/commands.lua](lua/commands.lua) for custom commands
- Edit [init.lua](init.lua) for startup wiring

## Philosophy

nnnvim aims to be the opposite of a bloated Neovim distro. It keeps the essentials, avoids unnecessary complexity, and leaves room for you to add what you actually need.

If you want a startup config that stays fast, readable, and simple, this is a good place to start.
