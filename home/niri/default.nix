{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.niri.homeModules.niri  # Import Niri's home-manager module
    ./settings.nix                # Your custom configuration files for Niri
    ./keybinds.nix
  ];
}