 {lib, config, pkgs, ... }:

let
  apps = import ./applications.nix { inherit pkgs; };
in {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    pactl = "${pkgs.pulseaudio}/bin/pactl";
    wpctl = "${pkgs.wireplumber}/bin/wpctl";

    volume-up = spawn wpctl [ "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
    volume-down = spawn wpctl [ "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];
    volume-mute = spawn wpctl [ "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
    mic-mute = spawn wpctl [ "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
  in {
    # Mostrar overlay de atajos
    "Mod+Shift+Slash".action = show-hotkey-overlay;

    # Aplicaciones principales
    "Mod+T".action = spawn "ghostty";
    "Mod+D".action = spawn "fuzzel";
    "Super+Alt+L".action = spawn "swaylock";

    # Control de volumen (funciona cuando está bloqueado)
    "XF86AudioRaiseVolume" = {
      action = volume-up;
      allow-when-locked = true;
    };
    "XF86AudioLowerVolume" = {
      action = volume-down;
      allow-when-locked = true;
    };
    "XF86AudioMute" = {
      action = volume-mute;
      allow-when-locked = true;
    };
    "XF86AudioMicMute" = {
      action = mic-mute;
      allow-when-locked = true;
    };

    # Gestión de ventanas
    "Mod+Q".action = close-window;

    # Navegación con HJKL (vim-style)
    "Mod+H".action = focus-column-left;
    "Mod+J".action = focus-window-down;
    "Mod+K".action = focus-window-up;
    "Mod+L".action = focus-column-right;

    # Mover ventanas con HJKL
    "Mod+Ctrl+H".action = move-column-left;
    "Mod+Ctrl+J".action = move-window-down;
    "Mod+Ctrl+K".action = move-window-up;
    "Mod+Ctrl+L".action = move-column-right;

    # Navegación rápida
    "Mod+Home".action = focus-column-first;
    "Mod+End".action = focus-column-last;
    "Mod+Ctrl+Home".action = move-column-to-first;
    "Mod+Ctrl+End".action = move-column-to-last;

    # Navegación entre monitores con HJKL
    "Mod+Shift+H".action = focus-monitor-left;
    "Mod+Shift+J".action = focus-monitor-down;
    "Mod+Shift+K".action = focus-monitor-up;
    "Mod+Shift+L".action = focus-monitor-right;

    # Mover columnas entre monitores con HJKL
    "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
    "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
    "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
    "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

    # Navegación de workspaces
    "Mod+Page_Down".action = focus-workspace-down;
    "Mod+Page_Up".action = focus-workspace-up;
    "Mod+U".action = focus-workspace-down;
    "Mod+I".action = focus-workspace-up;
    "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
    "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
    "Mod+Ctrl+U".action = move-column-to-workspace-down;
    "Mod+Ctrl+I".action = move-column-to-workspace-up;

    # Mover workspaces
    "Mod+Shift+Page_Down".action = move-workspace-down;
    "Mod+Shift+Page_Up".action = move-workspace-up;
    "Mod+Shift+U".action = move-workspace-down;
    "Mod+Shift+I".action = move-workspace-up;

    # Rueda del mouse para workspaces
    "Mod+WheelScrollDown" = {
      action = focus-workspace-down;
      cooldown-ms = 150;
    };
    "Mod+WheelScrollUp" = {
      action = focus-workspace-up;
      cooldown-ms = 150;
    };
    "Mod+Ctrl+WheelScrollDown" = {
      action = move-column-to-workspace-down;
      cooldown-ms = 150;
    };
    "Mod+Ctrl+WheelScrollUp" = {
      action = move-column-to-workspace-up;
      cooldown-ms = 150;
    };

    # Rueda del mouse para columnas
    "Mod+WheelScrollRight".action = focus-column-right;
    "Mod+WheelScrollLeft".action = focus-column-left;
    "Mod+Ctrl+WheelScrollRight".action = move-column-right;
    "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

    # Shift + rueda para navegación horizontal
    "Mod+Shift+WheelScrollDown".action = focus-column-right;
    "Mod+Shift+WheelScrollUp".action = focus-column-left;
    "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
    "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

    # Acceso directo a workspaces específicos
    "Mod+1".action = focus-workspace "browser";
    "Mod+2".action = focus-workspace "vesktop";

    # Acceso directo a workspaces por número
    "Mod+3".action = focus-workspace 3;
    "Mod+4".action = focus-workspace 4;
    "Mod+5".action = focus-workspace 5;
    "Mod+6".action = focus-workspace 6;
    "Mod+7".action = focus-workspace 7;
    "Mod+8".action = focus-workspace 8;
    "Mod+9".action = focus-workspace 9;

    # Mover columnas a workspaces específicos
    "Mod+Ctrl+1".action = move-column-to-workspace "browser";
    "Mod+Ctrl+2".action = move-column-to-workspace "vesktop";
    "Mod+Ctrl+3".action = move-column-to-workspace 3;
    "Mod+Ctrl+4".action = move-column-to-workspace 4;
    "Mod+Ctrl+5".action = move-column-to-workspace 5;
    "Mod+Ctrl+6".action = move-column-to-workspace 6;
    "Mod+Ctrl+7".action = move-column-to-workspace 7;
    "Mod+Ctrl+8".action = move-column-to-workspace 8;
    "Mod+Ctrl+9".action = move-column-to-workspace 9;

    # Gestión de columnas y ventanas
    "Mod+BracketLeft".action = consume-or-expel-window-left;
    "Mod+BracketRight".action = consume-or-expel-window-right;
    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;

    # Cambiar tamaños preestablecidos
    "Mod+R".action = switch-preset-column-width;
    "Mod+Shift+R".action = switch-preset-window-height;
    "Mod+Ctrl+R".action = reset-window-height;

    # Maximizar y pantalla completa
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+Ctrl+F".action = expand-column-to-available-width;

    # Centrar columna
    "Mod+C".action = center-column;

    # Ajustes finos de ancho
    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Equal".action = set-column-width "+10%";

    # Ajustes finos de altura
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Equal".action = set-window-height "+10%";

    # Ventanas flotantes
    "Mod+V".action = toggle-window-floating;
    "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

    # Modo tabulado
    "Mod+W".action = toggle-column-tabbed-display;

    # Escape de atajos (útil para clientes de escritorio remoto)
    "Mod+Escape" = {
      action = toggle-keyboard-shortcuts-inhibit;
      allow-inhibiting = false;
    };

    # Salir de niri
    "Mod+Shift+E".action = quit;
    "Ctrl+Alt+Delete".action = quit;

    # Apagar monitores
    "Mod+Shift+P".action = power-off-monitors;

    # Atajos adicionales de tu configuración original
    "super+b".action = spawn apps.browser;
    "super+Return".action = spawn apps.terminal;
    "super+Control+Return".action = spawn apps.editor;
    "super+E".action = spawn apps.fileManager;
    "super+f".action = fullscreen-window;
    "super+t".action = toggle-window-floating;

    # Capturas de pantalla con grim y slurp
    "control+shift+1".action = spawn "${pkgs.bash}/bin/bash" [
      "-c"
      "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy"
    ];

    "control+shift+2".action = spawn "${pkgs.bash}/bin/bash" [
      "-c"
      "${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png"
    ];
  };
}
