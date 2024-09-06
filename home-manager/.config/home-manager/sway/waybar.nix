{ config, pkgs, lib, ... }:

let
  colorScheme = import ./material-dark-yellow.nix;
  # scratchpadIndicatorScript = builtins.fetchurl {
  #   url = https://raw.githubusercontent.com/justinesmithies/sway-dotfiles/master/.local/bin/statusbar/scratchpad-indicator.sh;
  #   sha256 = "0xv2w1512gv31sbnwd1grdhrcvzngn8ljdj3x61mqgcqfcp57mwz";
  # };
  font = "Ubuntu Mono";
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top"; # Waybar at top layer
        position = "top"; # Waybar position (top|bottom|left|right)
        height = 32; # Waybar height
        width = 48; # Waybar width
        # Choose the order of the modules
        modules-left = [ "custom/power" "sway/mode" "custom/drive-mount" "custom/drive-unmount" "custom/media" "custom/screenshot" "custom/scan-barcode" "custom/color-picker" "pulseaudio" "backlight" "custom/emoji-picker" ];
        modules-center = [ "sway/workspaces" "sway/window" "custom/scratchpad-indicator" "tray" ];
        modules-right = [ "battery" "battery#bat2" "cpu" "memory" "custom/gpu" "disk" "temperature" "network" "custom/copy-date" "clock" ];
        "sway/workspaces" = {
          disable-scroll = true;
          disable-markup  = false;
          all-outputs = false;
          format = "  {icon}  ";
          #format ="{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
            "focused" = "";
            "default" = "";
          };
        };
        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        "sway/language" = {
          format = "{}";
          max-length = 50;
        };
        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y/%m/%d} ";
          format = "{:%H:%M} ";
        };
        "cpu" = {
          format = "{usage}%  CPU";
        };
        "memory" = {
          format = "{}% ";
        };
        "disk" = {
          format = "{}% ";
          tooltip-format = "{used} / {total} used";
        };
        "temperature" = {
          # thermal-zone = 2;
          "hwmon-path" = "/sys/class/hwmon/hwmon1/temp1_input";
          critical-threshold = 80;
          # format-critical = "{temperatureC}°C ";
          format = "{temperatureC}°C ";
        };
        "backlight" = {
          # device = "acpi_video1";
          format = "{percent}% {icon}";
          states = [ "0" "50" ];
        };
        "battery" = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          # "format-good" = ""; # An empty format will hide the module
          # "format-full" = "";
          format-icons = [ "" "" "" "" "" ];
        };
        "battery#bat2" = {
          "bat" = "BAT2";
        };
        "network" = {
          # "interface" = "wlp2s0"; # (Optional) To force the use of this interface
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = "{ifname} = {ipaddr}/{cidr} ";
          "format-disconnected" = "Disconnected ⚠";
          "interval" = 7;
        };
        "bluetooth" = {
          format = "<b>{icon}</b>";
          format-alt = "{status} {icon}";
          interval = 30;
          format-icons = {
            "enabled" = "";
            "disabled" = "";
          };
          tooltip-format = "{}";
        };
        "pulseaudio" = {
          #"scroll-step" = 1;
          "format" = "{volume}% {icon}";
          "format-bluetooth" = "{volume}% {icon}";
          "format-muted" = "";
          "format-icons" = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" ""];
          };
          "on-click" = "pavucontrol";
        };
        "custom/media" = {
          "format" = "{icon} {}";
          "return-type" = "json";
          "max-length" = 40;
          "format-icons" = {
            "spotify" = "";
            "default" = "🎜";
          };
          "escape" = true;
          "exec" = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
        };
        "custom/power" = {
          format = "";
          on-click = "swaynag --border-bottom-size 0 --details-border-size 0 --button-border-size 0 --button-margin 5 --message-padding=8 --button-padding=8 --background=${colorScheme.background} --text=${colorScheme.on_background} --button-background=${colorScheme.surface_variant} --button-text=${colorScheme.on_surface_variant} -f ${font} -t warning -m 'Power Menu Options' -b '⏻︁ Power off'  'shutdown -P now' -b '↻︁ Restart' 'shutdown -r now' -b '🛌︁ Hibernate' 'systemctl hibernate' -b '🛌︁ Hybrid-sleep' 'systemctl hybrid-sleep' -b '🛌︁ Suspend' 'systemctl suspend' -b '︁ Logout' 'swaymsg exit' -b ' Lock' 'swaylock-fancy -f ${font}'";
          #on-click = "sh $HOME/.config/waybar/power-menu.sh";
        };
        "custom/gpu" = {
          # Use either the next line or the second and third next line
          "exec" = "radeontop -d - -l 1 | tr -d '\n' | cut -s -d ',' -f3 | cut -s -d ' ' -f3 | tr -d '%' | awk '{ print $1 }' | tr -d '\n'";
          #"exec" = "radeontop -d - -l 1 | tr -d '\n' | cut -s -d ',' -f3 | cut -s -d ' ' -f3 | tr -d '%' | awk '{ print $1 }' | tr -d '\n'";
          "format" = "{}%  GPU";
          "interval" = 10;
        };
        "custom/screenshot" = {
          "format" = " ";
          "tooltip-format" = "Take a screenshot";
          "on-click" = "sh $HOME/.config/sway/screenshot.sh";
        };
        "custom/scan-barcode" = {
          "format" = "";
          "tooltip-format" = "Scan a barcode on the screen(s)";
          "on-click" = "sh $HOME/.config/sway/scan-barcode.sh";
        };
        "custom/color-picker" = {
          "format" = "";
          "tooltip-format" = "Pick a color on the screen(s)";
          "on-click" = "sh $HOME/.config/sway/color-picker.sh";
        };
        "custom/drive-mount" = {
          "format" = "";
          "tooltip" = "true";
          "tooltip-format" = "Mount /dev/sde1";
          "on-click" = "sh $HOME/.config/sway/drive-mount.sh";
        };
        "custom/drive-unmount" = {
          "format" = "";
          "tooltip" = "true";
          "tooltip-format" = "Unmount /dev/sde1";
          "on-click" = "sh $HOME/.config/sway/drive-unmount.sh";
        };
        "custom/emoji-picker" = {
          "format" = "🏳️‍🌈";
          "tooltip" = "true";
          "tooltip-format" = "Pick an emoji and copy it to the clipboard";
          "on-click" = "wofi-emoji";
        };
        "custom/copy-date" = {
          "format" = "📅";
          "tooltip" = "true";
          "tooltip-format" = "Copy the current date to the clipboard";
          "on-click" = "sh $HOME/.config/sway/copy-date.sh";
        };
        # "custom/scratchpad-indicator" = {
        #   "format-text" = "{}";
        #   "return-type" = "json";
        #   "interval" = 2;
        #   "exec" = "sh ${scratchpadIndicatorScript} 2> /dev/null";
        #   "exec-if" = "exit 0";
        #   "on-click"= "swaymsg 'scratchpad show'";
        #   "on-click-right" = "swaymsg 'move scratchpad'";
        # };
      };
    };
    style = ''

      * {
        border-radius: 0.4rem;
        font-family: '${font}', 'Font Awesome';
        font-size: 13px;
        min-height: 0;
      }

      #window, #workspaces button.urgent, #workspaces button.focused, .workspaces button, #mode, #custom-power, #tray, #clock, #battery, #cpu, #custom-gpu, #memory, #disk, #temperature, #backlight, #network, #pulseaudio, #custom-media, #idle_inhibitor, #custom-drive-mount, #custom-drive-unmount, #custom-screenshot, #custom-scan-barcode, #custom-color-picker, #custom-emoji-picker, #custom-copy-date, #custom-scratchpad-indicator {
        padding: 0 10px;
        margin: 0 3px;
        background-color: #${colorScheme.background};
        color: #${colorScheme.on_background};
      }

      /*window.waybar {
      }*/

      #window {
        background-color: #${colorScheme.primary};
        color: #${colorScheme.on_primary};
      }

      #workspaces {
        color: #${colorScheme.on_background};
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button {
        padding: 0 0px;
      }

      #workspaces button.focused {
        padding: 0 0px;
        background-color: #${colorScheme.surface_variant};
        color: #${colorScheme.on_surface_variant};
      }

      #workspaces button.urgent {
        padding: 0 0px;
        background-color: #${colorScheme.error};
        color: #${colorScheme.on_error};
      }

      #custom-power {
        margin-left: 0;
        padding: 0 12px;
        background-color: #${colorScheme.primary_container};
        color: #${colorScheme.on_primary_container};
      }

      #clock {
        margin-right: 0;
        background-color: #${colorScheme.surface_variant};
        color: #${colorScheme.on_surface_variant};
      }

      #battery {
        background-color: #${colorScheme.secondary};
        color: #${colorScheme.on_secondary};
      }

      #battery.charging {
        background-color: #${colorScheme.primary};
        color: #${colorScheme.on_primary};
      }

      @keyframes blink {
        to {
          background-color: #${colorScheme.tertiary};
          color: #${colorScheme.on_tertiary};
        }
      }

      #battery.critical:not(.charging) {
        background-color: #${colorScheme.error};
        color: #${colorScheme.on_error};
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #cpu {
        background-color: #${colorScheme.tertiary};
        color: #${colorScheme.on_tertiary};
      }

      #custom-gpu {
        background-color: #${colorScheme.tertiary};
        color: #${colorScheme.on_tertiary};
      }

      #memory {
        background-color: #${colorScheme.tertiary_container};
        color: #${colorScheme.on_tertiary_container};
      }

      #network {
        background-color: #${colorScheme.secondary};
        color: #${colorScheme.on_secondary};
      }

      #network.disconnected {
        background-color: #${colorScheme.error};
        color: #${colorScheme.on_error};
      }

      #pulseaudio {
        background-color: #${colorScheme.secondary};
        color: #${colorScheme.on_secondary};
      }

      #pulseaudio.muted {
        background-color: #${colorScheme.surface_variant};
        color: #${colorScheme.on_surface_variant};
      }

      #temperature {
        background-color: #${colorScheme.tertiary};
        color: #${colorScheme.on_tertiary};
      }

      #temperature.critical {
        background-color: #${colorScheme.error};
        color: #${colorScheme.on_error};
      }

      #idle_inhibitor.activated {
        background-color: #${colorScheme.tertiary};
        color: #${colorScheme.on_tertiary};
      }

      #custom-screenshot {
        background-color: #${colorScheme.tertiary_container};
        color: #${colorScheme.on_tertiary_container};
      }

      #custom-drive-mount {
        background-color: #${colorScheme.tertiary};
        color: #${colorScheme.on_tertiary};
      }

      #custom-drive-unmount {
        background-color: #${colorScheme.error_container};
        color: #${colorScheme.on_error_container};
      }

      #custom-scan-barcode {
        background-color: #${colorScheme.on_background};
        color: #${colorScheme.background};
      }

      #custom-color-picker {
        background-color: #${colorScheme.primary};
        color: #${colorScheme.on_primary};
      }
    '';
  };
}
