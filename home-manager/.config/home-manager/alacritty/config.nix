{config, pkgs, ...}:
{
  programs.alacritty = {
    /* enable   = true; */
    settings = {
        env.TERM = "xterm-256color";

        draw_bold_text_with_bright_colors = true;
        scrolling.history = 100000;

        font.normal.family = "Ubuntu Mono";
        font.size = 12.0;

        live_config_reload = true;
        selection.save_to_clipboard = true;
        selection.semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";

        window.decorations = "none";
        window.opacity = 0.5;
    };
  };
}
