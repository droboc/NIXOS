{ lib, pkgs, ... }:

{
  programs.niri.settings = {
    # Input configuration
    input = {
      keyboard.xkb = {
        # You can set rules, model, layout, variant and options.
        # layout = "us,ru";
        # options = "grp:win_space_toggle,compose:ralt,ctrl:nocaps";
      };

      touchpad = {
        tap = true;
        natural-scroll = true;
        # dwt = true;
        # dwtp = true;
        # drag-lock = true;
        # accel-speed = 0.2;
        # accel-profile = "flat";
        # scroll-method = "two-finger";
        # disabled-on-external-mouse = true;
      };

      mouse = {
        # natural-scroll = true;
        # accel-speed = 0.2;
        # accel-profile = "flat";
        # scroll-method = "no-scroll";
      };

      trackpoint = {
        # natural-scroll = true;
        # accel-speed = 0.2;
        # accel-profile = "flat";
        # scroll-method = "on-button-down";
        # scroll-button = 273;
        # middle-emulation = true;
      };

      # warp-mouse-to-focus = true;
      # focus-follows-mouse.max-scroll-amount = "0%";
    };

    # Output configuration - Tu monitor QM-G24
    outputs."DP-2" = {
      mode = "1920x1080@60.000";  # Modo actual (puedes cambiar a 165Hz si quieres)
      scale = 1.0;  # 100% scaling (perfecto para tu monitor de 24")
      transform = "normal";
      position = {
        x = 0;
        y = 0;
      };
    };
    
    # Alternativas de refresh rate para tu monitor:
    # mode = "1920x1080@165.001";  # Máximo refresh rate
    # mode = "1920x1080@144.042";  # 144Hz para gaming
    # mode = "1920x1080@120.000";  # 120Hz
    
    # Si quieres texto más grande, puedes usar:
    # scale = 1.25;  # 125% scaling

    # Layout configuration
    layout = {
      gaps = 16;
      center-focused-column = "never";
      
      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];

      default-column-width = { proportion = 0.5; };

      focus-ring = {
        enable = true;
        width = 4;
        active-color = "#7fc8ff";
        inactive-color = "#505050";
      };

      border = {
        enable = false;
        width = 4;
        active-color = "#ffc87f";
        inactive-color = "#505050";
      };

      shadow = {
        enable = false;
        # softness = 30;
        # spread = 5;
        # offset = { x = 0; y = 5; };
        # color = "#0007";
      };

      struts = {
        # left = 64;
        # right = 64;
        # top = 64;
        # bottom = 64;
      };
    };

    # Screenshot configuration
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    # Animation settings
    animations = {
      # enable = true;
      # slowdown = 1.0;
    };

    # Window rules are defined in rules.nix
    # Keybinds are defined in keybinds.nix
    # Autostart apps are defined in autostart.nix
  };
}
