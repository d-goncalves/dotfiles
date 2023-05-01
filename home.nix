{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "diogo";
  home.homeDirectory = "/home/diogo";

  targets.genericLinux.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = (with pkgs;[
    pkgs.fd
    pkgs.fzf
    pkgs.git
    pkgs.git
    pkgs.htop
    pkgs.nodejs
    pkgs.python3 # this somehow fucks up the nix shell -f default.nix shell so disabling that rn
    pkgs.ripgrep
    pkgs.tmux
    pkgs.vlc
    pkgs.zsh
    pkgs.stow
    pkgs.xclip
  ]);

  /* pkgs.python311.withPackages(ps: [ */
  /*         pylint # static checking */
  /*         requests # HTTP library */
  /*         setuptools # setup.py */
  /*         black */
  /*         isort */
  /* ]) */

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  /* programs.alacritty.enable = true; */
  programs.urxvt.enable = true;
}
