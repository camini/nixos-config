{ config, lib, pkgs, ...}:

{
  imports = 
    [
      ./hardware-configuration.nix
      ./config/VM.nix
      ./config/AMD-pstate.nix
      ./config/Alias.nix      
      ./config/Nix-clean.nix
      ./config/Gnome-clean.nix
    ];

  #/--------------------\# 
  #| ° Kernel Version ° |#
  #\--------------------/#
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #/-----------------------------\# 
  #| ° Boot Loader & Animation ° |#
  #\-----------------------------/#
  boot = {
    loader = {
     systemd-boot.enable      = true;
     efi.canTouchEfiVariables = true;
    };
    #plymouth = {
    #  enable = true;
    #  theme  = "breeze";
    #};
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
  
  #/---------\# 
  #| ° GPU ° |#
  #\---------/#
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  }; 
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  #/-----------------------------------\# 
  #| ° Xserver & Desktop Environment ° |#
  #\-----------------------------------/#
  services.xserver = {
    enable = true;
    displayManager.gdm.enable   = true;
    desktopManager.gnome.enable = true;
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

  #/---------------------\# 
  #| ° System Packages ° |#
  #\---------------------/#
  environment.systemPackages = with pkgs; [
   # hardware
   compsize
   pciutils
   usbutils   
   # Editeur/code
   vscode
   bash-completion
   git
   # Theme/visuel
   adw-gtk3
   qogir-icon-theme
   mangohud
   # Internet/mail
   firefox
   thunderbird
   discord
   # Shell
   neofetch
   btop
   discord
   # Emulateur
   yuzu-mainline
   # Video
   libsForQt5.kdenlive
   obs-studio-plugins.obs-vkcapture
   obs-studio
   vlc
   # Gnome extensions
   gnome.gnome-tweaks
   gnomeExtensions.blur-my-shell
   gnomeExtensions.spotify-tray
   gnomeExtensions.appindicator
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
  fileSystems."/home/cammi/Jeux" =
  { device = "/dev/disk/by-label/Jeux";
    fsType = "ext4";
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
