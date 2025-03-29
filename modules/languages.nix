{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    go
    gopls
    lua-language-server
    stylua
    gcc
    nodejs
    tailwindcss
    tailwindcss-language-server
    typescript-language-server
  ];
}
