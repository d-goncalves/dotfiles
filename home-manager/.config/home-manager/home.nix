{ pkgs, lib, ... }:
let
    username = "diogo";
    homeDirectory =  "/home/diogo";
in {
  home = {
    inherit username;
    inherit homeDirectory;
    stateVersion = "23.11";
  };

  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    bat
    dbeaver-bin
    delta
    fd
    ghc
    ghcid
    git
    htop
    insomnia
    jq
    nodejs
    ripgrep
    stow
    vlc
    xclip
  ];

  programs = {

    home-manager.enable = true;
    jq.enable = true;

    fzf = {
      enable = true;
      changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
      tmux.enableShellIntegration = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    autojump = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
