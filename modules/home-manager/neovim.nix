{ config, pkgs,inputs, ... }:
{
  enable = true;
  package=inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
}
