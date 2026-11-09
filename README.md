# dotfiles

These are my terminal settings for **macOS, Linux and WSL**. One command installs the tools and links the configuration files.

The setup has these parts:

- **zsh** with the starship prompt
- **Neovim**
- **tmux**
- **git**
- One terminal theme for iTerm2 and Windows Terminal

## Quick start

```sh
git clone https://github.com/d-goncalves/dotfiles ~/dotfiles
cd ~/dotfiles

./bootstrap.sh                 # install tools (Homebrew), link config files (stow), install oh-my-zsh and nvim plugins, install terminal font (Linux)
./bootstrap.sh --extras        # also install Brewfile.extras (homelab and optional tools)
./bootstrap.sh --lsp           # also install Brewfile.lsp (language servers for nvim)
./bootstrap.sh --no-brew       # only link config files (use this on a machine where you are not an administrator)
./bootstrap.sh --no-plugins    # do not install oh-my-zsh, its plugins, or the nvim plugins and tools
./bootstrap.sh --no-fonts      # do not download the terminal font (Linux)
./bootstrap.sh --terminal      # WSL: install the font and apply the theme to Windows Terminal
./bootstrap.sh --update        # only update oh-my-zsh and the zsh plugins
./bootstrap.sh --dry-run       # show what the script will do, but do not change anything
```

The script does these steps:

1. It installs the tools with Homebrew.
2. It links the configuration files with [GNU Stow](https://www.gnu.org/software/stow/).
3. It sets up oh-my-zsh and the Neovim plugins.

You can run the script again at any time. It does not cause damage.

## Contents

| Folder     | Description                                                                                                                              |
| ---------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `zsh/`     | Shell settings: oh-my-zsh, starship prompt, fzf, zoxide                                                                                  |
| `nvim/`    | Neovim settings: LSP, treesitter, telescope, format on save                                                                              |
| `tmux/`    | tmux settings: `ctrl-a` prefix, vim keys, shared clipboard                                                                               |
| `git/`     | git settings: delta diffs, rebase on pull, rerere                                                                                        |
| `desktop/` | Settings for each OS: `macos/` has iTerm2, `linux/` has sway and Alacritty, `windows/` has Windows Terminal                              |
| `hooks/`   | git hooks that stop a commit if it contains secrets                                                                                      |

## Structure

- **One repository for three systems.** Shared files are in the top-level folder. Files for one OS are in `desktop/`.
- **Machine-specific settings are not in the repository.** Put your git identity, tokens and personal aliases in `~/code/config`. Make this folder from the templates in [`config.example/`](config.example/). Do not commit it.
- **It is safe to publish.** The commit and push hooks stop credentials and shell-history files.

## Licence

This project has an MIT licence.
