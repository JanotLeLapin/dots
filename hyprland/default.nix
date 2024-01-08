{
  enable = true;
  # enableNvidiaPatches = true;
  extraConfig = builtins.readFile ./hyprland.conf;
  settings = {
    env = "XCURSOR_SIZE,24";

    input = {
      kb_layout = "fr,us";
      kb_variant = "";
      kb_model = "";
      kb_options = "";
      kb_rules = "";
      follow_mouse = 1;
      touchpad = {
        natural_scroll = true;
      };
      sensitivity = 0;
    };

    general = {
      gaps_in = 4;
      gaps_out = 10;
      border_size = 4;
      "col.active_border" = "rgba(ec4899aa) rgba(a855f7aa) rgba(6366f1aa) 135deg";
      "col.inactive_border" = "rgba(595959aa)";

      layout = "dwindle";
    };

    animations = { enabled = false; };

    decoration = {
      rounding = 0;
      inactive_opacity = 1;
      active_opacity = 1;
      fullscreen_opacity = 1;

      drop_shadow = false;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = { new_is_master = true; };
    gestures = { workspace_swipe = false; };
  };
}
