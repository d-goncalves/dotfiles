{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    prefix = "C-a";
    extraConfig = builtins.readFile ./.tmux.conf;
  };
}
