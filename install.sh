#!/bin/sh

sh <(curl -L https://nixos.org/nix/install) --daemon

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

home-manager switch

cd ~/dotfiles || exit
# Symlink configurations
stow home-manager

python -m ensurepip --upgrade
/home/diogo/.nix-profile/bin/python3 -m pip install pynvim
npm install -g neovim

# [TMUX] - Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
