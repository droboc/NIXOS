# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/languages.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 5;
    
    # Kernel optimizations from JaKooLit config
    kernelPackages = pkgs.linuxPackages_zen; # zen Kernel for better performance
    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" # mask 1.5 mins systemd bug
      "nowatchdog" 
      "modprobe.blacklist=sp5100_tco" # watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" # watchdog for Intel
    ];
    
    # Make /tmp a tmpfs for better performance
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };
    
    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    
    plymouth.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Guayaquil";
  
  # Automatic timezone based on IP location (optional, comment out time.timeZone above if using this)
  # services.automatic-timezoned.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
  
  # Garbage collection automation
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Networking
  networking = {
    networkmanager.enable = true;
    hostName = "nixos"; # Define your hostname
    timeServers = lib.mkDefault [ "pool.ntp.org" ];
  };

  # Fonts configuration (expanded from JaKooLit)
  fonts.packages = with pkgs; [
    # Your original fonts
    nerd-fonts.jetbrains-mono
    openmoji-color
    
    # Additional fonts from JaKooLit config
    dejavu_fonts
    fira-code
    fira-code-symbols
    font-awesome
    hackgen-nf-font
    ibm-plex
    inter
    material-icons
    maple-mono.NF
    nerd-fonts.im-writing
    nerd-fonts.blex-mono
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    roboto
    roboto-mono
    victor-mono
  ];

  # Programs configuration
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
    
    waybar.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    git.enable = true;
    
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        exo
        mousepad
        thunar-archive-plugin
        thunar-volman
        tumbler
      ];
    };
    
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = ["git"];
        theme = "agnoster"; 
      };
      
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      
      promptInit = ''
        fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
        # Set-up icons for files/directories in terminal using lsd
        alias ls='lsd'
        alias l='ls -l'
        alias la='ls -a'
        alias lla='ls -la'
        alias lt='ls --tree'
        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;
        setopt appendhistory;
      '';
    };
    
    xwayland.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nm-applet.indicator = true;
  };

  # Services configuration
  services = {
    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "drobles";
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    
    # Additional services from JaKooLit
    gvfs.enable = true;
    tumbler.enable = true;
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;
    
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    
    libinput.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
    blueman.enable = true;
    fwupd.enable = true;
    upower.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  # System packages (combined and organized)
  environment.systemPackages = with pkgs; [
    # Your original packages
    pciutils starship zsh atuin nushell zip libreoffice stow neovim
    pavucontrol networkmanager playerctl btop light hyprpaper hyprpicker
    hypridle hyprlock grimblast imagemagick lazygit sqlite gpclient anydesk
    fd discord ghostty wofi gtk3 greetd.tuigreet hyprland waybar dunst
    libnotify brightnessctl pamixer grim slurp wl-clipboard fzf git
    firefox eza unzip ripgrep
    
    # Additional packages from JaKooLit config
    bc baobab btrfs-progs clang curl cpufrequtils duf findutils ffmpeg
    glib gsettings-qt killall libappindicator openssl vim wget
    xdg-user-dirs xdg-utils fastfetch
    (mpv.override {scripts = [mpvScripts.mpris];})
    
    # Hyprland specific packages
    cava cliphist loupe gnome-system-monitor gtk-engine-murrine inxi jq
    kitty libsForQt5.qtstyleplugin-kvantum networkmanagerapplet nwg-displays
    nwg-look nvtopPackages.full polkit_gnome libsForQt5.qt5ct
    kdePackages.qt6ct kdePackages.qtwayland kdePackages.qtstyleplugin-kvantum
    rofi-wayland swappy swaynotificationcenter swww wallust wlogout
    xarchiver yad yt-dlp lsd
  ];
  
  # XDG Portal configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };
  
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
    
    # Enhanced polkit configuration from JaKooLit
    polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("users")
            && (
              action.id == "org.freedesktop.login1.reboot" ||
              action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
              action.id == "org.freedesktop.login1.power-off" ||
              action.id == "org.freedesktop.login1.power-off-multiple-sessions"
            )
          )
        {
          return polkit.Result.YES;
        }
      })
    '';
  };
  
  # PAM configuration for swaylock
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
 
  virtualisation.docker.enable = true;

  # zram configuration for better memory management
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  # Power management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

  # Bluetooth configuration
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
    
    # OpenGL
    graphics.enable = true;
  };

  # Define a user account
  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;
    users.drobles = {
      isNormalUser = true;
      description = "drobles";
      extraGroups = [ 
        "wheel" "docker" "networkmanager" "libvirtd" "scanner" 
        "lp" "video" "input" "audio" 
      ];
      homeMode = "755";
      packages = with pkgs; [
        tree
      ];
    };
  };

  environment.shells = with pkgs; [ zsh ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "drobles" = import ./home.nix;
    };
  };

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  console.keyMap = "us";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.11"; # Did you read the comment?
}
