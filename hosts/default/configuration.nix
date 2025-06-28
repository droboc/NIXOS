# Configuración NixOS limpia
{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/languages.nix
  ];

  # Boot configuration básico
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 5;
    };
  };

  # Basic system configuration
  time.timeZone = "America/Guayaquil";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # Networking
  networking = {
    hostName = "default"; # Cambiar por tu hostname preferido
    useDHCP = lib.mkDefault true;
    timeServers = lib.mkDefault [ "pool.ntp.org" ];
  };

  # Nix configuration
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  # Fonts básicas del sistema
  fonts.packages = with pkgs; [
    dejavu_fonts
    noto-fonts
  ];

  # Hardware
  hardware = {
    graphics.enable = true;
  };

  # Programs mínimos
  programs = {
    firefox.enable = true;
    git.enable = true;
    niri.enable = true;
  };

  # Services mínimos
  services = {
    # greetd: Display manager moderno en Rust para Wayland
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri";
          user = "greeter";
        };
      };
    };

    # Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    # System services básicos
    openssh.enable = true;
  };

  # Paquetes esenciales mínimos
  environment.systemPackages = with pkgs; [
    # Development
    git curl wget vim

    # Applications
    discord
    firefox
    ghostty
    alacritty
    fuzzel
  ];


  xdg.portal = {
    enable = true;
    configPackages = [
      pkgs.xdg-desktop-portal-gtk # Essential for GTK applications
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  # Security básico
  security.sudo.wheelNeedsPassword = false;

  # User configuration
  users.users.drobles = {
    isNormalUser = true;
    description = "drobles";
    extraGroups = [ "wheel" ];
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.drobles = import ./home.nix;
  };

  system.stateVersion = "24.11";
}
