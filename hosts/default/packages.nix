{
  pkgs,
  ...
}:

with pkgs;
[

  # Applications
  discord
  alacritty
  fuzzel

  # Development
  nodejs
  rustup
  gcc
  gh
  nixfmt-rfc-style
  nixpkgs-fmt
  python3
  python3Packages.python-lsp-server
  python3Packages.requests
  ruff  # linter + formatter
  go
  gopls  # LSP
  bun
  typescript-language-server
  tailwindcss
  tailwindcss-language-server
  lua-language-server
  stylua  # formatter

  # Utilities
  vim
  pipewire

]
