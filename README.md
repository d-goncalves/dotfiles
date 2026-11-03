# dotfiles

My terminal setup for **macOS, Linux and WSL**. One command installs the tools and links the config.

**zsh** + starship prompt · **Neovim** · **tmux** · **git** · one terminal theme for iTerm2 and Windows Terminal

## Quick start

```sh
git clone https://github.com/d-goncalves/dotfiles ~/dotfiles
cd ~/dotfiles

./bootstrap.sh                 # tools (Homebrew), config links (stow), oh-my-zsh, nvim plugins, terminal font (Linux)
./bootstrap.sh --extras        # also install Brewfile.extras (homelab and optional tools)
./bootstrap.sh --lsp           # also install Brewfile.lsp (language servers for nvim)
./bootstrap.sh --no-brew       # link configs only, for machines without admin rights
./bootstrap.sh --no-plugins    # skip oh-my-zsh, its plugins, and the nvim plugin and tool install
./bootstrap.sh --no-fonts      # skip downloading the terminal font (Linux)
./bootstrap.sh --terminal      # WSL: install the font and apply the theme to Windows Terminal
./bootstrap.sh --update        # only update oh-my-zsh and the zsh plugins
./bootstrap.sh --dry-run       # print what would happen, change nothing
```

It installs the tools with Homebrew, links the config with [GNU Stow](https://www.gnu.org/software/stow/), and sets up oh-my-zsh and the Neovim plugins. Safe to re-run.

## What's inside

|            |                                                                                                               |
| ---------- | ------------------------------------------------------------------------------------------------------------- |
| `zsh/`     | Shell: oh-my-zsh, starship prompt, fzf, zoxide                                                                |
| `nvim/`    | Neovim: LSP, treesitter, telescope, format on save                                                            |
| `tmux/`    | tmux: `ctrl-a` prefix, vim keys, shared clipboard                                                             |
| `git/`     | git: delta diffs, rebase on pull, rerere                                                                      |
| `desktop/` | Per-OS terminal and window manager: `macos/` iTerm2, `linux/` sway and Alacritty, `windows/` Windows Terminal |
| `hooks/`   | git hooks that refuse commits containing secrets                                                              |

## How it's put together

- **One repo, three systems.** Everything shared lives at the top level, and OS-specific config lives under `desktop/`.
- **Machine-specific settings stay out of the repo.** Git identity, tokens and personal aliases go in `~/code/config`, created from the templates in [`config.example/`](config.example/) and never committed.
- **Safe to publish.** Commit and push hooks block credentials and shell-history files.

MIT licensed.
