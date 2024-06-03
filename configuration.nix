{ config, lib, pkgs, ...}:

{
  imports = 
    [
      ./hardware-configuration.nix
      ./config/AMD-pstate.nix
      ./config/Alias.nix      
      ./config/Nix-clean.nix
      ./config/Gnome-clean.nix
      ./config/Nvidia.nix
      ./config/VM.nix
    ];

  #/--------------------\# 
  #| ° Kernel Version ° |#
  #\--------------------/#
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernel.sysctl = { "vm.max_map_count" = 2147483642; };
  services.envfs.enable = true;
  nix.settings.trusted-substituters = ["https://ai.cachix.org"];
  nix.settings.trusted-public-keys = ["ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="];
  
  #/-----------------------------\# 
  #| ° Boot Loader & Animation ° |#
  #\-----------------------------/#
  boot = {
    loader = {
     systemd-boot.enable      = true;
     efi.canTouchEfiVariables = true;
    };
  };

  #/----------------\# 
  #| ° Networking ° |#
  #\----------------/#
  networking = {
    hostName = "nixos";
    networkmanager.enable = true; 
  };

  #/----------------------\# 
  #| ° Time & Languages ° |#
  #\----------------------/#
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  #/--------------------------\# 
  #| ° Keyboard Disposition ° |#
  #\--------------------------/#
  services.xserver.xkb = {
    layout  = "fr";
    variant = "azerty";
  };
  #/-----------\# 
  #|  ° ENV °  |#
  #\-----------/#
   environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  #/-----------\# 
  #| ° Sound ° |#
  #\-----------/#
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable       = true;
      support32Bit = true;
    };
    pulse.enable   = true;
  };

  #/-----------------------------------\# 
  #| ° Xserver & Desktop Environment ° |#
  #\-----------------------------------/#
  services.xserver = {
    enable = true;
    displayManager.gdm.enable   = true;
    desktopManager.gnome.enable = true;
    #displayManager.sddm.enable = true;
    #desktopManager.plasma5.enable = true;
    #displayManager.defaultSession = "plasmawayland";
    #displayManager.sddm.wayland.enable = true;
  };
    
  #/--------------------------\# 
  #| ° Users Configurations ° |#
  #\--------------------------/#
  # ------------ # 
  #/-----------\#
  #| ° cammi ° |#
  #\-----------/#
  users.users.cammi = {
    isNormalUser = true;
    description = "cammi";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "usb" ];
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];

  #/---------------------\# 
  #| ° System Packages ° |#
  #\---------------------/#


  environment.systemPackages = with pkgs; [
   # hardware
   nvd
   hwinfo
   pciutils
   usbutils   
   # Editeur/code
   bash-completion
   git
   # Bureautique
   libreoffice-fresh
   hunspellDicts.fr-any
   # Theme/visuel
   adw-gtk3
   qogir-icon-theme
   mangohud
   goverlay
   # Internet/mail
   transmission
   firefox
   thunderbird
   vesktop
   youtube-music
   # Shell
   nerdfonts
   neofetch
   fastfetch   
   btop
   # Emulateur
   ryujinx
   # Impression 3d
   prusa-slicer
   # Video
   obs-studio-plugins.obs-vkcapture
   obs-studio
   celluloid
   # Gnome extensions
   gnome.gnome-tweaks
   gnomeExtensions.blur-my-shell
   gnomeExtensions.appindicator
   gnomeExtensions.dash-to-dock	
  ];
  # script qui s'exécute après un rebuild
  system.activationScripts.report-changes = ''
    PATH=$PATH:${lib.makeBinPath [ pkgs.nvd pkgs.nix ]}
    nvd diff $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2)'';

  #/-----------------\# 
  #| ° FileSystems ° |#
  #|   Mount Options |#
  #\-----------------/#
  fileSystems = {
    "/".options =     [ "subvol=@"     "compress=zstd:3" "noatime" "defaults" "discard"];
    "/home".options = [ "subvol=@home" "compress=zstd:3" "noatime" "defaults" "discard"];
  };

  #/-----------\# 
  #| ° Steam ° |#
  #\-----------/#
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; 
  dedicatedServer.openFirewall = true; 
  gamescopeSession.enable = true;
  };

  #/---------------------\# 
  #| ° Unfree Software ° |#
  #\---------------------/#
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  #/-------------------------------\# 
  #| ° Nix Configuration Version ° |#
  #|   DO NOT MODIFY !!!           |#
  #\-------------------------------/#
  system.stateVersion = "23.11";
}
