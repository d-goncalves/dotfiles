{ pkgs, lib, ... }:
let username = "diogo";
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
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

  imports = [ tmux/config.nix zsh/config.nix nvim/config.nix ];

  programs = {

    home-manager.enable = true;
    jq.enable = true;

    helix = {
      enable = true;

      languages = {
        language = [{
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
        }];
      };

      settings = {
        theme = "everblush";
        editor = {
          file-picker.hidden = false;
          lsp.display-messages = true;
          lsp.display-inlay-hints = true;
          indent-guides.render = true;
          indent-guides.character = "╎";
          cursor-shape.insert = "bar";
          cursor-shape.select = "block";
          soft-wrap.enable = true;
          completion-replace = true;
        };
        keys.insert = { j.k = "normal_mode"; };
      };

    };
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
