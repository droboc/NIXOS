{
  config,
  pkgs,
  ...
}: {
  programs.niri.settings = {
    layer-rules = [
      {
        matches = [
          {
            namespace = "wallpaper";
          }
        ];
        place-within-backdrop = true;
      }
    ];
    window-rules = [
      {
        matches = [
          { app-id = "firefox"; }
        ];
        open-on-workspace = "browser";
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
      }

      # Vesktop with rounded corners
      {
        matches = [
          { app-id = "vesktop"; }
        ];
        open-on-workspace = "vesktop";
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
      }

      # Default rule for all other windows with rounded corners
      {
        matches = [{}]; # Matches all windows not matched by above rules
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
      }
    ];
  };
}
