{ config, pkgs, lib, ... }:
let username = "diogo";
in {
  home.username = username;
  home.homeDirectory = "/home/${username}";

  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
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
    firefox
    ghcid
    ghc
    statix
    nixfmt
    tree-sitter
  ];

  imports =
    [ tmux/config.nix alacritty/config.nix zsh/config.nix nvim/config.nix ];

  programs.chromium = {
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
      { id = "fihnjjcciajhdojfnbdddfaoknhalnja"; } # I don't care about cookies
    ];
  };

  programs.jq.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
    tmux.enableShellIntegration = true;
    enableZshIntegration = true;
  };

  xdg.desktopEntries = {
    chromium = {
      name = "chromium";
      genericName = "Web Browser";
      exec = "chromium %U";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
      mimeType = [ "text/html" "text/xml" ];
    };
    alacritty = {
      name = "terminal boy";
      genericName = " Terminal";
      exec = "alacritty";
      terminal = false;
    };
  };

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
