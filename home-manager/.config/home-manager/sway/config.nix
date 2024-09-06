{ pkgs, lib, ... }:
# let modifier = config.wayland.windowManager.sway.config.modifier;
let modifier = "mod4";
in {
  programs.swaylock = {
    enable = true;
    settings = { color = "000000"; };
  };
  wayland.windowManager.sway.enable = true;
  wayland.windowManager.sway.config.bars =
    [{ command = "swaybar_command waybar"; }];
  wayland.windowManager.sway.config.terminal =
    "${pkgs.alacritty}/bin/alacritty";
  wayland.windowManager.sway.config.window.titlebar = false;
  wayland.windowManager.sway.extraConfig = builtins.readFile ./sway.conf;
  wayland.windowManager.sway.config.fonts = { names = [ "Ubuntu NF" ]; };

  wayland.windowManager.sway.config.input = {
    "*" = {
      natural_scroll = "disabled";
      tap = "enabled";
      "xkb_options" = "ctrl:nocaps";
    };
  };

  wayland.windowManager.sway.config.menu = "rofi -show run";

  wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
    # ${pkgs.foot}/bin/foot
    "${modifier}+t" = "exec alacritty";
    "${modifier}+d" = "exec $menu";
    "${modifier}+Return" = "exec alacritty";
    "${modifier}+Shift+q" = "kill";
    "${modifier}+Shift+c" = "reload";
    # "${modifier}+Shift+l" = "exec swaylock -f -F -e -k -c 000000";
    "${modifier}+Shift+i" = "exec fnottctl dismiss";
    "${modifier}+Shift+o" = "exec fnottctl unpause";
    "${modifier}+Shift+p" = "exec fnottctl pause";
  };

  imports = [ ./waybar.nix ];

  # services.xserver.displayManager.sessionPackages = with pkgs; [ sway ];
  services.swayosd.enable = true;
  services.swaync.enable = true;

  programs.rofi = {
    enable = true;
    theme = ./rofi.rasi;
  };
}
