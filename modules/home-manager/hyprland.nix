{pkgs, ...}: {
  enable = true;
  settings = {
    "$mod" = "SUPER";
    monitor = [
      "DP-1,preferred,auto,auto"
      "HDMI-A-1,disable"
    ];
    
    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 20;
      border_size = 2;
      col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      col.inactive_border = "rgba(595959aa)";
      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
    };

    decoration = {
      rounding = 10;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      
      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };
      
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
    };

    dwindle.preserve_split = true;
    master.new_status = "master";
    
    input = {
      kb_layout = "us";
      follow_mouse = 1;
      sensitivity = 0;
    };

    gestures.workspace_swipe = false;

    bind = [
      "$mod, Q, exec, ghostty"
      "$mod, C, killactive"
      "$mod, M, exit"
      "$mod, E, exec, dolphin"
      "$mod, V, togglefloating"
      "$mod, R, exec, wofi --show drun"
      "$mod, P, pseudo"
      "$mod, J, togglesplit"
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
    ]
    ++ (
      builtins.concatLists (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString(x + 1 - (c * 10));
        in [
          "$mod, ${ws}, workspace, ${toString (x + 1)}"
          "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        ]
      )
      10)
    );
  };

  extraConfig = ''
    exec-once = ghostty
    exec-once = waybar
    
    bezier = easeOutQuint,0.23,1,0.32,1
    bezier = easeInOutCubic,0.65,0.05,0.36,1
    bezier = linear,0,0,1,1
    bezier = almostLinear,0.5,0.5,0.75,1.0
    bezier = quick,0.15,0,0.1,1
    
    animation = global, 1, 10, default
    animation = border, 1, 5.39, easeOutQuint
    animation = windows, 1, 4.79, easeOutQuint
    animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
    animation = windowsOut, 1, 1.49, linear, popin 87%
    animation = fadeIn, 1, 1.73, almostLinear
    animation = fadeOut, 1, 1.46, almostLinear
    animation = fade, 1, 3.03, quick
    animation = layers, 1, 3.81, easeOutQuint
    animation = layersIn, 1, 4, easeOutQuint, fade
    animation = layersOut, 1, 1.5, linear, fade
    animation = fadeLayersIn, 1, 1.79, almostLinear
    animation = fadeLayersOut, 1, 1.39, almostLinear
    animation = workspaces, 1, 1.94, almostLinear, fade
    animation = workspacesIn, 1, 1.21, almostLinear, fade
    animation = workspacesOut, 1, 1.94, almostLinear, fade

    device {
      name = epic-mouse-v1
      sensitivity = -0.5
    }

    xwayland {
      force_zero_scaling = true
    }

    windowrulev2 = suppressevent maximize, class:.*
    windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
  '';
}
