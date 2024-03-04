{ pkgs, ... }:
let
  username = "diogo";
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
    dbeaver
    bat
    cargo
    ghcid
    ghc
    statix
    nixfmt
    tree-sitter
  ];

  imports =
    [ tmux/config.nix zsh/config.nix nvim/config.nix ];

  programs = {
    home-manager.enable = true;

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
