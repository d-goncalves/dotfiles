# Dotfiles

One setup for macOS, Linux and WSL. Generic config lives here; anything specific to a machine
(tokens, work aliases, git identity) lives in `~/work` and never touches this repo.

## Install

```sh
git clone <this repo> ~/work/dotfiles
cd ~/work/dotfiles
./bootstrap.sh            # tools, config links and plugins
```

Options: `--extras` (homelab and optional tools), `--no-brew` (link configs only, for machines
without admin rights), `--no-plugins`, `--dry-run`.

## How it is organised

Each top-level folder is a [stow](https://www.gnu.org/software/stow/) package that mirrors `$HOME`:

| Package | What it holds |
|---|---|
| `zsh` | shell config (`~/.zshenv` points zsh at `~/.config/zsh`) |
| `git` | generic git config and global ignore |
| `tmux`, `nvim`, `alacritty` | tool configs |
| `linux-desktop` | sway, waybar, wofi, mako, only linked when `sway` is installed |

`Brewfile` holds the core tools. `Brewfile.extras` holds optional ones.
`legacy/` holds the old Nix, home-manager and Ansible setup.

## Machine-specific config

| File | Purpose |
|---|---|
| `~/work/.zsh` | tokens, work aliases, internal hosts. Sourced by `.zshrc` when present |
| `~/work/.gitconfig` | git identity and commit signing. Included by the generic git config |

## Notes

### Neovim themes

- [TokyoNight](https://github.com/ghifarit53/tokyonight-vim)
- [Vscode](https://github.com/Mofiqul/vscode.nvim)
- [OneDarkPro](https://github.com/olimorris/onedarkpro.nvim)
- [Edge](https://github.com/sainnhe/edge)
- [OneDark Nvim](https://github.com/navarasu/onedark.nvim)
- [EverBlush](https://github.com/Everblush/everblush.vim)
- [One Monokai](https://github.com/cpea2506/one_monokai.nvim)
- [Kanagawa](https://github.com/rebelot/kanagawa.nvim)
- [Oceanic Next](https://github.com/mhartington/oceanic-next)
- [Sonokai](https://github.com/sainnhe/sonokai)
- [OneHalf](https://github.com/sonph/onehalf)
- [XCode](https://github.com/arzg/vim-colors-xcode)
- [Hybrid Material](https://github.com/kristijanhusak/vim-hybrid-material)

### Theme

- \[ ] [srcery-colors](https://srcery-colors.github.io/)

### Fonts

[Download fonts](https://www.nerdfonts.com/font-downloads)

- \[ ] [Sarasa-Gothic](https://github.com/be5invis/Sarasa-Gothic)
- \[ ] [Hasklig](https://github.com/i-tu/Hasklig)
- \[ ] [FiraCode](https://github.com/tonsky/FiraCode)
- \[ ] [Hack](https://github.com/source-foundry/Hack)
- \[ ] [MesloLGS NF](https://github.com/romkatv/dotfiles-public/blob/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf)
