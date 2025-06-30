{ lib, config, pkgs, ... }:

{
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # Aplicaciones básicas
    "Super+Return".action = spawn "alacritty";  # Terminal (cambia por tu terminal preferido)
    "Super+b".action = spawn "firefox";         # Firefox
    "Super+space".action = spawn "fuzzel";      # Fuzzel launcher
    "Super+q".action = close-window;            # Cerrar ventana

    # Navegación básica
    "Super+Left".action = focus-column-left;
    "Super+Right".action = focus-column-right;
    "Super+Down".action = focus-workspace-down;
    "Super+Up".action = focus-workspace-up;

    # Mover ventanas
    "Super+Shift+Left".action = move-column-left;
    "Super+Shift+Right".action = move-column-right;
    "Super+Shift+Down".action = move-column-to-workspace-down;
    "Super+Shift+Up".action = move-column-to-workspace-up;

    # Ventana flotante y pantalla completa
    "Super+f".action = fullscreen-window;
    "Super+t".action = toggle-window-floating;
  };
}
