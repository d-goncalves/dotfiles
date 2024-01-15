{ config, pkgs, ... }: {
  programs.neovim = {
    enable = false;
    defaultEditor = true;
    # extraConfig = builtins.readFile ./init.vim;
    # extraLuaConfig = builtins.readFile ./init.lua;

    extraPackages = with pkgs; [
      tree-sitter
      nodejs
      # Language Servers
      # Bash
      nodePackages.bash-language-server
      # Dart
      dart
      # Elixir
      beam.packages.erlang.elixir-ls
      # Erlang
      beam.packages.erlang.erlang-ls
      # Haskell
      # stable.haskellPackages.haskell-language-server
      # Lua
      lua-language-server
      # Nix
      nil
      nixfmt
      statix
      # python-debug
      black
      isort
      mypy
      # Typescript
      nodePackages.typescript-language-server
      # Web (ESLint, HTML, CSS, JSON)
      # nodePackages.vscode-langservers-extracted
      # Telescope tools
      ripgrep
      fd
    ];
  };
}
