
{ config, lib, pkgs, ... }:

let
  # Atajo para ejecutar comandos de shell
  sh = config.lib.niri.actions.spawn "sh" "-c";
  # Tu terminal preferida
  terminal = "ghostty";
in
{
  programs.niri.settings.binds = with config.lib.niri.actions;
    let
      # Define Mod como la tecla Super/Windows. Cambia a "Alt" si lo prefieres.
      Mod = "Mod";
    in
    {
      # --- Atajos Esenciales ---
      "${Mod}+E".action = spawn "thunar";
      "${Mod}+T".action = spawn terminal;
      "${Mod}+D".action = spawn "fuzzel";
      "${Mod}+Q".action = close-window;
      "${Mod}+Shift+E".action = quit; # Salir de niri

      # --- Movimiento y Foco ---
      "${Mod}+h".action = focus-column-left;
      "${Mod}+j".action = focus-window-down;
      "${Mod}+k".action = focus-window-up;
      "${Mod}+l".action = focus-column-right;

      "${Mod}+Left".action = focus-column-left;
      "${Mod}+Down".action = focus-window-down;
      "${Mod}+Up".action = focus-window-up;
      "${Mod}+Right".action = focus-column-right;

      "${Mod}+Ctrl+h".action = move-column-left;
      "${Mod}+Ctrl+j".action = move-window-down;
      "${Mod}+Ctrl+k".action = move-window-up;
      "${Mod}+Ctrl+l".action = move-column-right;

      # --- Control de Ventanas y Layout ---
      "${Mod}+F".action = maximize-column;
      "${Mod}+Shift+F".action = fullscreen-window;
      "${Mod}+V".action = switch-focus-between-floating-and-tiling;
      "${Mod}+Shift+V".action = toggle-window-floating;

      # --- Control de Medios ---
      "XF86AudioRaiseVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
      "XF86AudioLowerVolume".action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      "XF86AudioMute".action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

      # --- Capturas de Pantalla ---
      "Print".action.screenshot-screen = [ ];
      "${Mod}+Print".action = screenshot-window;

      # --- Espacios de Trabajo (Workspaces) ---
      # Cambiar a un espacio de trabajo
      "${Mod}+1".action.focus-workspace = [ 1 ];
      "${Mod}+2".action.focus-workspace = [ 2 ];
      "${Mod}+3".action.focus-workspace = [ 3 ];
      "${Mod}+4".action.focus-workspace = [ 4 ];
      "${Mod}+5".action.focus-workspace = [ 5 ];

      # Mover ventana a un espacio de trabajo
      "${Mod}+Ctrl+1".action.move-window-to-workspace = [ 1 ];
      "${Mod}+Ctrl+2".action.move-window-to-workspace = [ 2 ];
      "${Mod}+Ctrl+3".action.move-window-to-workspace = [ 3 ];
      "${Mod}+Ctrl+4".action.move-window-to-workspace = [ 4 ];
      "${Mod}+Ctrl+5".action.move-window-to-workspace = [ 5 ];
    };
}
