{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = builtins.readFile ./init.lua;

    extraPackages = with pkgs; [
      # Lsp Configuration
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
      statix
      terraform-ls
      tflint
      yaml-language-server
      rust-analyzer
      typos-lsp

      # Linting/
      (python3.withPackages (p: (with p; [ python-lsp-ruff ])))
      black
      isort
      mypy
      pyright

      # Vim Configuration
      nodejs
    ];
  };
}
