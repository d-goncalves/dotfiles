#!/bin/sh

# Defines
FONT_DESTINATION="$HOME/.local/share/fonts/"
FONT_URL="https://github.com/romkatv/dotfiles-public/blob/master/.local/share/fonts/NerdFonts/"

######### Package installation #########
apt-get install zsh
apt-get install tmux
apt-get install git
apt-get install nodejs
apt-get install ripgrep
apt-get install fd-find
apt-get install alacritty
apt-get install stow
apt-get install neovim
# NOTE: This Neovim be outdated

apt-get install qbittorrent
apt-get install vlc


######### Python install #########
# Check if python3 is installed
if ! [ "$(which python)" ]; then
    apt-get install python3
fi
# Check if pip3 is installed
if ! [ "$(which pip3)" ]; then
    apt-get install python3-pip
fi
pip3 install pynvim


########## Fonts ##########
FONT_REGULAR="MesloLGS%20NF%20Regular.ttf"
FONT_ITALIC="MesloLGS%20NF%20Italic.ttf"
FONT_BOLD="MesloLGS%20NF%20Bold.ttf"
FONT_BOLD_ITALIC="MesloLGS%20NF%20Bold%20Italic.ttf"

wget -P $FONT_DESTINATION $FONT_URL$FONT_REGULAR
wget -P $FONT_DESTINATION $FONT_URL$FONT_ITALIC
wget -P $FONT_DESTINATION $FONT_URL$FONT_BOLD
wget -P $FONT_DESTINATION $FONT_URL$FONT_BOLD_ITALIC

########## Install config ##########

# Symlink configurations
stow nvim
stow tmux
stow zsh
stow alacritty

# [ZSH] Install packages
~/.zsh/install.sh

# Change shell
chsh -s $(which zsh)


# [TMUX] - Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
