{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "diogo";
  home.homeDirectory = "/home/diogo";

  targets.genericLinux.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = (with pkgs;[
    fd
    git
    htop
    nodejs
    python3 # this somehow fucks up the nix shell -f default.nix shell so disabling that rn
    ripgrep
    vlc
    stow
    xclip

    ansible-lint
    yamlfmt
    yamlfix
    codespell
  ]);

  /* pkgs.python311.withPackages(ps: [ */
  /*         pylint # static checking */
  /*         requests # HTTP library */
  /*         setuptools # setup.py */
  /*         black */
  /*         isort */
  /* ]) */




  programs.bat.enable = true;

  imports = [
      ./tmux/config.nix
      ./alacritty/config.nix
      ./zsh/config.nix
  ];

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;

  programs.autojump.enable = true;
  programs.autojump.enableZshIntegration = true;

  programs.fzf.enable = true;
  programs.fzf.changeDirWidgetOptions = ["--preview 'tree -C {} | head -200'"];
  programs.fzf.tmux.enableShellIntegration = true;
  programs.fzf.enableZshIntegration = true;

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
}
