{ config, pkgs, ... }:

{
  home.username = "diogo";
  home.homeDirectory = "/home/diogo";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
      bat
      jq
      ansible-language-server
      bash-language-server
      clang-tools
      dhall-lsp-server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      lua-language-server
      # nginx-language-server
      nil
      nodePackages.typescript-language-server
      terraform-ls
      tflint
      yaml-language-server
      rust-analyzer
      typos-lsp
      ansible-lint
      ty

      # # Linting/
      (python3.withPackages (p: (with p; [ py-spy python-lsp-ruff ])))
      isort
      mypy
      pyright

      # Vim Configuration
      nodejs
  ];

  programs.home-manager.enable = true;
}
