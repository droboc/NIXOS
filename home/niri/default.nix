{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.niri.homeModules.niri  # Import Niri's home-manager module
    ./settings.nix                # Configuración básica de niri
    ./keybinds.nix               # Atajos de teclado
  ];
}
