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
  protonplus
  lutris
  dolphin-emu
  prismlauncher
  heroic
  peazip

  # TUI
  btop
  yazi

  # Desktop
  hyprlock
  nwg-look
  walker

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
  curl
  jq
  socat
  tree
  libnotify
  nvd
  wl-clipboard
  pywalfox-native
  imagemagick
  amdvlk
  rar
  unzip
  droidcam
  gowall
  gruvbox-gtk-theme
  papirus-icon-theme
  grimblast
  gpu-screen-recorder
  mpv
  slop

  # Quickshell stuff
  qt6Packages.qt5compat
  libsForQt5.qt5.qtgraphicaleffects
  kdePackages.qtbase
  kdePackages.qtdeclarative

  # Niri (related packages)
  niri
  xwayland-satellite
  grim
  slurp
]
