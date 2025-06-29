{ lib, ... }:

{
  programs.niri.settings.window-rules = [
    # WezTerm workaround
    {
      matches = [
        { app-id = "^org\\.wezfurlong\\.wezterm$"; }
      ];
      default-column-width = {};
    }

    # Firefox Picture-in-Picture
    {
      matches = [
        {
          app-id = "firefox$";
          title = "^Picture-in-Picture$";
        }
      ];
      open-floating = true;
    }

    # Example: Block out password managers from screen capture
    # {
    #   matches = [
    #     { app-id = "^org\\.keepassxc\\.KeePassXC$"; }
    #     { app-id = "^org\\.gnome\\.World\\.Secrets$"; }
    #   ];
    #   block-out-from = "screen-capture";
    # }

    # Example: Enable rounded corners for all windows
    # {
    #   geometry-corner-radius = 12;
    #   clip-to-geometry = true;
    # }
  ];
}
