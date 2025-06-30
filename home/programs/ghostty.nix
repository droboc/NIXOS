{ pkgs, config, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      gtk-single-instance = true;
      font-size = 11;
      font-family = "JetBrainsMono Nerd Font";

      window-decoration = false;

      # Disables ligatures
      font-feature = [
        "-liga"
        "-dlig"
        "-calt"
      ];
    };
  };
}
