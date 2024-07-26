{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = builtins.readFile ./init.lua;

    extraPackages = with pkgs; [
      tree-sitter
      nodejs
      nodePackages.bash-language-server
      lua-language-server
      # Nix
      nil
      statix
      # python-debug
      black
      isort
      mypy
      # Typescript
      nodePackages.typescript-language-server
      ripgrep
      fd
    ];
  };
}
