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
  # Build essentials
  gcc

  # Python
  python3
  python3Packages.python-lsp-server
  python3Packages.requests
  ruff  # linter + formatter

  # Go
  go
  gopls  # LSP

  # JavaScript/TypeScript
  nodejs
  bun
  typescript-language-server

  # CSS/Tailwind
  tailwindcss
  tailwindcss-language-server

  # Lua
  lua-language-server
  stylua  # formatter

  # Utilities
  vim
  curl
]
