{ pkgs, ... }:
let username = "diogo";
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    insomnia
    fd
    git
    htop
    nodejs
    ripgrep
    vlc
    stow
    xclip
    delta
    dbeaver-bin
    bat
    cargo
    ghcid
    ghc
    statix

    # Editor LSP/Configurations Helix configuration
    nil
    tree-sitter
    yaml-language-server
    ansible-language-server
    terraform-ls
    bash-language-server
    marksman
    haskell-language-server
    docker-compose-language-service
    dhall-lsp-server
    clang
    (python3.withPackages (p: (with p; [
      python-lsp-server
      python-lsp-ruff
    ])))
    # python-lsp-server
  ];

  imports = [ tmux/config.nix zsh/config.nix nvim/config.nix ];

  programs = {

    home-manager.enable = true;

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

    chromium = {
      enable = true;
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # DarkReader
        { id = "jeoacafpbcihiomhlakheieifhpjdfeo"; } # Disconnect
        { id = "kbfnbcaeplbcioakkpcpgfkobkghlhen"; } # Grammarly
        { id = "gphhapmejobijbbhgpjhcjognlahblep"; } # Gnome Shell integration
        { id = "hlepfoohegkhhmjieoechaddaejaokhf"; } # Refined Github
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
        { id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # Stylus
        { id = "fihnjjcciajhdojfnbdddfaoknhalnja"; } # no cookies
      ];
    };
    fzf = {
      enable = true;
      changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
      tmux.enableShellIntegration = true;
      enableZshIntegration = true;
    };
    jq.enable = true;
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
