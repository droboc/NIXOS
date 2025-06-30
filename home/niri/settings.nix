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
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
      };
    };
  };
}
