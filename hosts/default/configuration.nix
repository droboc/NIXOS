# Configuración NixOS limpia
{ config, lib, pkgs, inputs,self,  ... }:

{
  imports = [
    ./hardware-configuration.nix
    "${self}/system/packages.nix"
    "${self}/system/greeter/greetd.nix"
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
    
    git.enable = true;
    
  };

  # Services mínimos
  services = {
    

    # Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    # System services básicos
    openssh.enable = true;
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
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users."drobles" = import ./home.nix;
  };

  system.stateVersion = "24.11";
}
