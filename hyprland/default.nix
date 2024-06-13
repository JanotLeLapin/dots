{ pkgs, specialArgs, ... }: {
  enable = true;
  # enableNvidiaPatches = specialArgs.extra.gpu == "nvidia";
  settings = {
    env = "XCURSOR_SIZE,24";
    "$mod" = "SUPER";

    exec-once = [
      "eww open bar"
      "mako"
      "${pkgs.swaybg}/bin/swaybg -i $HOME/.wallpaper"
    ];

    monitor = specialArgs.extra.monitors;

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
      "col.active_border" = "rgba(${specialArgs.theme.colors.main-0}aa) rgba(${specialArgs.theme.colors.main-1}aa) rgba(${specialArgs.theme.colors.main-2}aa) 45deg";
      "col.inactive_border" = "rgba(595959aa)";

      layout = "dwindle";
    };

    animations = {
      enabled = true;
    };

    decoration = {
      rounding = 8;
      inactive_opacity = 1;
      active_opacity = 1;
      fullscreen_opacity = 1;

      blur = {
        size = 7;
        passes = 3;
        xray = true;
        brightness = 0.8;
        contrast = 1.0;
        vibrancy = 0.6;
        vibrancy_darkness = 0.6;
        popups = true;
      };

      drop_shadow = false;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";
    };

    windowrulev2 = [
      "opacity 0.8,class:(kitty)"
      "opacity 0.8,class:(discord)"
    ];

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = { new_is_master = true; };
    gestures = { workspace_swipe = false; };

    bind = let 
      workspaces = {
        ampersand  = "1";
        eacute     = "2";
        quotedbl   = "3";
        apostrophe = "4";
        parenleft  = "5";
        minus      = "6";
        egrave     = "7";
        underscore = "8";
        ccedilla   = "9";
        agrave     = "10";
      };

      genWorkspaceBindings = key: "$mod,       ${key}, workspace,       ${workspaces."${key}"}";
    in [
      "$mod, Space, togglefloating"
      "$mod, Q,     killactive"
      "$mod, M,     exit"
      "$mod, F,     fullscreen"
      "$mod, J,     togglesplit"

      # Focus
      "$mod, left,  movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up,    movefocus, u"
      "$mod, down,  movefocus, d"

      # Apps
      "$mod, RETURN, exec, kitty"
      "$mod, D,      exec, wofi --show drun"

      ", Print, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -d)\" - | ${pkgs.wl-clipboard}/bin/wl-copy"
    ]
      ++ (map (key: ''$mod, ${key}, workspace, ${workspaces."${key}"}'') (builtins.attrNames workspaces))
      ++ (map (key: ''$mod SHIFT, ${key}, movetoworkspace, ${workspaces."${key}"}'') (builtins.attrNames workspaces));

    binde = let
      pactl = "${pkgs.pulseaudio}/bin/pactl";
      brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
    in [
      ", XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
      ", XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
      ", XF86MonBrightnessUp,   exec, ${brightnessctl} set +10%"
      ", XF86MonBrightnessDown, exec, ${brightnessctl} set  10%-"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
