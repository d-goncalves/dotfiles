{
  description = "My dotfiles configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    homeConfigurations = {
        "diogo" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs { system = "x86_64-linux"; };
            modules = [
                ./home.nix
                tmux/config.nix
                zsh/config.nix
                nvim/config.nix
            ];
        };
    };
  };
}
