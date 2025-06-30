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
  ];

  home.username = "drobles";
  home.homeDirectory = "/home/drobles";

  home.packages = allPackages;

  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
