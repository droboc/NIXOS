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
  home.username = "drobles";
  home.homeDirectory = "/home/drobles";

  home.packages = allPackages;

  home.stateVersion = "24.11";

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}