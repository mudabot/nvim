# Neovim Config

My personal Neovim setup, managed with [lazy.nvim](https://github.com/folke/lazy.nvim).
It includes GitHub Copilot inline suggestions and Copilot Chat, and it is designed to be
restored quickly on a fresh machine.

## Features

- Plugin management with `lazy.nvim` (lazy-loaded, lockfile for reproducible installs)
- GitHub Copilot ghost-text suggestions via `copilot.vim`
- Copilot Chat via `CopilotChat.nvim` (works on the free plan with Auto model selection)
- Status line with mode, git, file info and a clock
- Dark theme to match the terminal (Catppuccin Mocha)

## Requirements

- Neovim 0.10 or newer
- Git
- `make` and a C compiler (needed to build CopilotChat's `tiktoken` step)
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal for icons
- A GitHub account with Copilot enabled (the free plan works)
- Node.js, which `copilot.vim` needs for its language server

On Debian/Ubuntu-based systems:

```bash
sudo apt update
sudo apt install -y git make gcc curl unzip nodejs npm neovim
```

## Installation

Back up any existing config, then clone this repo:

```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
git clone https://github.com/mudabot/nvim.git ~/.config/nvim
nvim
```

On first launch, `lazy.nvim` installs all plugins automatically. Restart Neovim
once it finishes.

## GitHub Copilot setup

1. Open Neovim and run `:Copilot auth`, then complete the login in your browser.
2. Run `:CopilotChatModels`. On the free plan only **Auto** is available, which is fine.
3. If chat shows `Model not found`, update the plugin with `:Lazy update CopilotChat.nvim`,
   restart Neovim and run `:CopilotChatReset`.

### Keybindings

| Key | Mode | Action |
|---|---|---|
| `<leader>cc` | normal, visual | Toggle Copilot Chat |
| `<Tab>` | insert | Accept ghost-text suggestion in normal buffers; complete in the chat prompt |
| `<C-j>` | insert | Accept Copilot suggestion (backup key) |
| `<C-s>` | insert (chat) | Send message |
| `<CR>` | normal (chat) | Send message |
| `g?` | normal (chat) | Show chat help |

Useful commands: `:CopilotChat`, `:CopilotChatModels`, `:CopilotChatReset`, `:CopilotChatDebugInfo`.

## Terminal theme

The Neovim colors are meant to match a Catppuccin Mocha terminal. For a matching prompt,
install [Starship](https://starship.rs/) and use its Catppuccin preset.

## Structure

```
~/.config/nvim
├── init.lua          # entry point, bootstraps lazy.nvim and loads settings
├── lazy-lock.json    # pinned plugin versions
└── lua/
    └── plugins/      # one file per plugin or group of plugins
```

## Troubleshooting

| Problem | Fix |
|---|---|
| No reply in chat | Send with `<CR>` in normal mode or `<C-s>` in insert mode |
| `Model not found` | Remove any hard-coded `model` option, update the plugin, run `:CopilotChatReset` |
| Tab does not accept suggestions | Run `:verbose imap <Tab>` to find which plugin owns the key |
| `tiktoken` build fails | Install `make` and `gcc`, then run `:Lazy build CopilotChat.nvim` |
| Missing icons | Install a Nerd Font and select it in your terminal |

## License

Personal configuration, use and adapt it however you like.
