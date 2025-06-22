{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python3
    python3Packages.pip
    go
    rust
    gopls
    lua-language-server
    stylua
    gcc
    nodejs
    tailwindcss
    tailwindcss-language-server
    typescript-language-server
    ruff
    python313Packages.python-lsp-server
  ];
}
