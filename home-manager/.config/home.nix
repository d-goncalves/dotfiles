{ pkgs, ... }:
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
    helix
    gitui


      ansible-language-server
      bash-language-server
      clang-tools
      dhall-lsp-server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      lua-language-server
      nginx-language-server
      nil
      nodePackages.typescript-language-server
      terraform-ls
      tflint
      yaml-language-server
      rust-analyzer
      typos-lsp
      ansible-lint

      # Linting/
      (python3.withPackages (p: (with p; [ py-spy python-lsp-ruff ])))
      black
      isort
      mypy
      pyright

      # Vim Configuration
      nodejs
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
