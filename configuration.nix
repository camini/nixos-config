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
    ];

  #/--------------------\# 
  #| ° Kernel Version ° |#
  #\--------------------/#
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernel.sysctl = { "vm.max_map_count" = 2147483642; };
  services.envfs.enable = true;

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
   hwinfo
   pciutils
   usbutils   
   # Editeur/code
   vscode
   bash-completion
   git
   # Bureautique
   libreoffice-fresh
   hunspellDicts.fr-any
   # Theme/visuel
   adw-gtk3
   qogir-icon-theme
   orchis-theme
   mangohud
   goverlay
   # Internet/mail
   transmission
   firefox
   thunderbird
   discord
   # Shell
   nerdfonts
   neofetch
   btop
   # Emulateur
   ryujinx
   # Impression 3d
   prusa-slicer
   # Video
   obs-studio-plugins.obs-vkcapture
   obs-studio
   vlc
   # Gnome extensions
   gnome.gnome-tweaks
   gnomeExtensions.blur-my-shell
   gnomeExtensions.appindicator
   gnomeExtensions.just-perfection
   gnomeExtensions.dash-to-dock	
  ];
    
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
  };

  #/---------------------\# 
  #| ° Unfree Software ° |#
  #\---------------------/#
  nixpkgs.config.allowUnfree = true;

  #/-------------------------------\# 
  #| ° Nix Configuration Version ° |#
  #|   DO NOT MODIFY !!!           |#
  #\-------------------------------/#
  system.stateVersion = "23.11";
}
