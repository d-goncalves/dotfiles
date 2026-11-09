# desktop

This folder has the terminal and window-manager settings. It has one folder for each OS.

| Folder     | Content                                       | How the settings are applied                                                       |
| ---------- | --------------------------------------------- | ---------------------------------------------------------------------------------- |
| `macos/`   | iTerm2 profile                                | stow links them into `$HOME`                                                       |
| `linux/`   | sway, waybar, mako, wofi, Alacritty           | stow links them into `$HOME` (only if sway or Alacritty is installed)              |
| `windows/` | Windows Terminal font and theme, for WSL      | No links. Scripts change the `settings.json` file of Windows Terminal.             |

## One palette

`palette.json` is the only color scheme. Its name is Vivid Black. It uses the Windows Terminal format.

- **iTerm2:** A script makes the profile from the palette.
  - After you change a color, do this command: `python3 desktop/macos/make-iterm-profile.py`.
  - The `--check` option shows if the profile is up to date.
  - The pre-commit hook stops a commit if the profile and the palette are different.
  - The generated profile turns off "separate colors for light and dark mode". It writes both variants. iTerm builds dynamic profiles on top of the Default profile. If the profile does not do this, it uses the colors of the Default profile.
- **Windows Terminal:** `windows/apply.py` reads the palette directly.
- **Alacritty:** It has its own palette (`cactus`) in its configuration file.

## Windows Terminal

Do one of these in Windows Terminal:

- Run `bootstrap.sh`.
- Run `./bootstrap.sh --terminal`.
- Run `windows/windows-terminal.sh`.

The script does these steps:

1. It installs the JetBrainsMono Nerd Font for the current Windows user. It does not need administrator rights.
2. It makes a backup of the settings file. The backup name has a time stamp.
3. It applies the color scheme and the font to the Ubuntu profiles. It keeps all other settings.

To run the tests, use this command: `python3 -I desktop/windows/tests/test_terminal_apply.py`.

### Manual installation

1. Install the JetBrainsMono Nerd Font on Windows. Windows cannot use the font from WSL.
   1. Download `JetBrainsMono.zip` from the [Nerd Fonts releases](https://github.com/ryanoasis/nerd-fonts/releases/latest).
   2. Select the `JetBrainsMonoNerdFont-*.ttf` files.
   3. Right-click and select Install.
2. In Windows Terminal, open Settings. Then select Open JSON file.
3. Copy `palette.json` into your `schemes` list.
4. Under `profiles.defaults`, set `"colorScheme": "Vivid Black"`. Set the font to `JetBrainsMono Nerd Font`, size 11.

You need Windows Terminal 1.19 or later.
