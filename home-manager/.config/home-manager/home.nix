{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "diogo";
  home.homeDirectory = "/home/diogo";

  targets.genericLinux.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = (with pkgs;[
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
    docker
    bat

    firefox
    ghcid
    ghc
    ansible-lint
    yamlfmt
    yamlfix
    codespell
    yaml-language-server
    (python311.withPackages (p: with p; [
      pylint # static checking
      black
      python-lsp-server
      isort
      requests
    ]))
  ]);




  programs.bat.enable = true;

  imports = [
    ./tmux/config.nix
    ./alacritty/config.nix
    ./zsh/config.nix
    ./nvim/config.nix
  ];


  programs.chromium.enable = true;
  programs.chromium.extensions = [
    { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
    { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
    { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
    { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # DarkReader
    { id = "jeoacafpbcihiomhlakheieifhpjdfeo"; } # Disconnect
    { id = "kbfnbcaeplbcioakkpcpgfkobkghlhen"; } # Grammarly
    { id = "gphhapmejobijbbhgpjhcjognlahblep"; } # Gnome Shell integration
    { id = "hlepfoohegkhhmjieoechaddaejaokhf"; } # Refined Github
    { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
    { id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # Stylus
    { id = "fihnjjcciajhdojfnbdddfaoknhalnja"; } # Stylus

  ];

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;

  programs.autojump.enable = true;
  programs.autojump.enableZshIntegration = true;

  programs.fzf.enable = true;
  programs.fzf.changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
  programs.fzf.tmux.enableShellIntegration = true;
  programs.fzf.enableZshIntegration = true;

  xdg.desktopEntries = {
    chromium = {
      name = "Example";
      genericName = "Web Browser";
      exec = "chromium %U";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
      mimeType = [ "text/html" "text/xml" ];
    };
  };


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
