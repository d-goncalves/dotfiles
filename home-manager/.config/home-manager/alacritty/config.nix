{ ... }: {
  programs.alacritty = {
    enable = false;
    settings = {
      env.TERM = "xterm-256color";

      #draw_bold_text_with_bright_colors = true;
      # draw_bold_text_with_bright_colors = false;
      scrolling.history = 100000;

      font.normal.family = "Ubuntu Mono";
      font.size = 12.0;

      live_config_reload = true;
      selection.save_to_clipboard = true;
      selection.semantic_escape_chars = '',│`|:"' ()[]{}<>	'';

      window.decorations = "none";
      window.opacity = 1.0;

      colors = {
        primary = {
          background = "0x000000";
          foreground = "0xffffff";
        };
        normal = {
          black = "0x000000";
          red = "0xfe0100";
          green = "0x33ff00";
          yellow = "0xfeff00";
          blue = "0x0066ff";
          magenta = "0xcc00ff";
          cyan = "0x00ffff";
          white = "0xd0d0d0";
        };
        bright = {
          black = "0x808080";
          red = "0xfe0100";
          green = "0x33ff00";
          yellow = "0xfeff00";
          blue = "0x0066ff";
          magenta = "0xcc00ff";
          cyan = "0x00ffff";
          white = "0xFFFFFF";
        };
      };
    };
  };
}
