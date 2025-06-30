{ config, pkgs, ... }:

{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      # Layout básico
      layout = {
        gaps = 6;
        focus-ring = {
          enable = true;
          width = 3;
          active.color = "#c488ec";
          inactive.color = "#505050";
        };
      };

      # Input básico
      input = {
        keyboard.xkb.layout = "us";
        focus-follows-mouse.enable = true;
      };

      # Variables de entorno mínimas para Wayland

      environment = {
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        ELECTRON_ENABLE_HARDWARE_ACCELERATION = "1";

        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
        DISPLAY = ":0";
      };

    };
  };
}
