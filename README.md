# dotfiles

Shell, editor and terminal config for macOS, Linux and WSL. [GNU Stow](https://www.gnu.org/software/stow/) links it into `$HOME`, and `bootstrap.sh` installs the tools around it: zsh with the starship prompt, Neovim, tmux, git, a terminal theme called "cactus" for iTerm2, Alacritty and Windows Terminal, and sway on Linux.

## Usage

```sh
git clone https://github.com/d-goncalves/dotfiles ~/work/dotfiles
cd ~/work/dotfiles

./bootstrap.sh                 # tools (Homebrew), config links (stow), zsh and tmux plugins, terminal font (Linux)
./bootstrap.sh --extras        # also install Brewfile.extras (homelab and optional tools)
./bootstrap.sh --no-brew       # link configs only, for machines without admin rights
./bootstrap.sh --no-plugins    # skip cloning the zsh and tmux plugins
./bootstrap.sh --no-fonts      # skip downloading the terminal font (Linux)
./bootstrap.sh --update        # only update the installed zsh and tmux plugins
./bootstrap.sh --dry-run       # print what would happen, change nothing
```

`bootstrap.sh` detects macOS, Linux or WSL and is safe to re-run. On macOS it links the iTerm2 profile and sets it as the default; restart iTerm to see it.

Tokens, work aliases and git identity stay out of the repo, in `~/work/.zsh` (sourced by `.zshrc`) and `~/work/.gitconfig` (included by the git config).

<details>
<summary>Windows Terminal (manual step)</summary>

1. Install FiraCode Nerd Font on Windows, since the font from WSL is not visible to Windows. Download `FiraCode.zip` from the [Nerd Fonts releases](https://github.com/ryanoasis/nerd-fonts/releases/latest), select the `FiraCodeNerdFontMono-*.ttf` files, right-click, Install. A per-user install needs no admin rights.
2. In Windows Terminal open Settings, then Open JSON file.
3. From `terminals/windows-terminal.json`, copy the `"schemes"` entry into your `schemes` list and the `"defaults"` keys into `profiles.defaults`. This needs Windows Terminal 1.19 or newer.

The palette lives in the iTerm2, Alacritty and Windows Terminal files, so keep them in sync when you change a color.

</details>
