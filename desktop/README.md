# desktop

Terminal and window-manager config, one folder per OS.

| Folder | What | How it is applied |
|---|---|---|
| `macos/` | iTerm2 profile | linked into `$HOME` by stow |
| `linux/` | sway, waybar, mako, wofi, Alacritty | linked into `$HOME` by stow (when sway or Alacritty is installed) |
| `windows/` | Windows Terminal font and theme, for WSL | not linked: scripts edit Windows Terminal's `settings.json` |

## One palette

`palette.json` is the single color scheme (Vivid Black, in Windows Terminal's format).

- **iTerm2:** the profile is generated from it. After changing a color run `python3 desktop/macos/make-iterm-profile.py`; `--check` tells you whether it is up to date, and the pre-commit hook refuses a commit where they disagree. The generated profile turns off "separate colors for light and dark mode" and writes both variants, because iTerm builds dynamic profiles on top of the Default profile and would otherwise inherit its colors.
- **Windows Terminal:** `windows/apply.py` reads it directly.
- **Alacritty** keeps its own palette (`cactus`) in its config file.

## Windows Terminal

Inside Windows Terminal, `bootstrap.sh` (or `./bootstrap.sh --terminal`, or `windows/windows-terminal.sh`) installs JetBrainsMono Nerd Font for the current Windows user, with no admin rights, and applies the scheme and font to the Ubuntu profiles. It keeps other settings and writes a timestamped backup first. Tests: `python3 -I desktop/windows/tests/test_terminal_apply.py`.

To do it by hand:

1. Install JetBrainsMono Nerd Font on Windows (the font from WSL is not visible to Windows): download `JetBrainsMono.zip` from the [Nerd Fonts releases](https://github.com/ryanoasis/nerd-fonts/releases/latest), select the `JetBrainsMonoNerdFont-*.ttf` files, right-click, Install.
2. In Windows Terminal open Settings, then Open JSON file.
3. Copy `palette.json` into your `schemes` list, then set `"colorScheme": "Vivid Black"` and the font (`JetBrainsMono Nerd Font`, size 11) under `profiles.defaults`. Needs Windows Terminal 1.19 or newer.
