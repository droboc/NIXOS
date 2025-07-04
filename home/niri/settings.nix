
{ config, pkgs, lib, ... }:

{
  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      input = {
        keyboard.xkb.layout = "us";
        mouse.accel-speed = 1.0;
      };

      prefer-no-csd = true;

      layout = {
        gaps = 16;
        border.width = 2;
        always-center-single-column = true;
        shadow.enable = true;
      };

      hotkey-overlay.skip-at-startup = true;
      clipboard.disable-primary = true;

      screenshot-path = "~/Pictures/Screenshots/%Y-%m-%dT%H:%M:%S.png";

      # Asegúrate de que swaybg esté instalado (está en tus systemPackages)
      # y reemplaza la ruta con la de tu fondo de pantalla.
      spawn-at-startup = [
        # Nix gestionará esta ruta relativa y la copiará a la store.
        { command = [ "${pkgs.swaybg}/bin/swaybg" "-m" "fill" "-i" "${../../assets/wallpaper.jpg}" ]; }
      ];

      window-rules = [
        {
          draw-border-with-background = false;
          geometry-corner-radius = {
            top-left = 8.0;
            top-right = 8.0;
            bottom-left = 8.0;
            bottom-right = 8.0;
          };
          clip-to-geometry = true;
        }
        {
          matches = [ { is-focused = false; } ];
          opacity = 0.95;
        }
      ];

      # Configuración de salida de ejemplo para un monitor de escritorio
      # Reemplaza 'DP-2' con el nombre de tu monitor (puedes encontrarlo con `niri msg --json outputs`)
      outputs."DP-2".scale = 1.0;
    };
  };

  }
