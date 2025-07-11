{
  config,
  pkgs,
  inputs,
  self,
  ...
}:

let
  allPackages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [
    ../../home/programs/ghostty.nix
    ../../home/programs/firefox.nix
    ../../home/programs/fuzzel.nix
    ../../home/programs/mako.nix
    ../../home/niri/default.nix
    ../../home/programs/nvim.nix
    ../../system/shell/nushell.nix
  ];

  home.username = "drobles";
  home.homeDirectory = "/home/drobles";

  home.packages = allPackages;

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
