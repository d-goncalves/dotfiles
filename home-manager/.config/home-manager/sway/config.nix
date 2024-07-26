{ ... }: {
  programs.swaylock = {
      enable = true;
      settings = {
          color = "000000";
      };
  };
  wayland.windowManager.sway.enable = true;
  wayland.windowManager.sway.extraConfig = builtins.readFile ./sway.conf;

  programs.rofi = {
      enable = true;
      theme = ./rofi.rasi;
  };
}
