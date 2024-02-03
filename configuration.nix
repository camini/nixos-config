{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ./VM.nix
      ];

  # Completion bash.
  programs.bash.enableCompletion = true;

  # Boot.
  boot.plymouth.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.fstrim.enable =  true;

  # GPU.
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.driSupport = true; 
  hardware.opengl.driSupport32Bit = true; 
     
  # Nom de la machine.
  networking.hostName = "nixos"; 
  
  # Montage disque Jeux.
    fileSystems."/home/cammi/Jeux" =
  { device = "/dev/disk/by-label/Jeux";
    fsType = "ext4";
  };
  
  # Activation réseau.
  networking.networkmanager.enable = true;

  # Timezone.
  time.timeZone = "Europe/Paris";

  # Locale.
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

  # X11.
  services.xserver.enable = true;

  # Gnome.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Keymap sur X11.
  services.xserver = {
    xkb.layout = "fr";
    xkb.variant = "azerty";
  };

  # Keymap console.
  console.keyMap = "fr";

  # Pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Compte utilisateur.
  users.users.cammi = {
    isNormalUser = true;
    description = "cammi";
    extraGroups = [ "video" "audio" "usb" "networkmanager" "wheel" ];
  };

  # Nettoyage Nix.
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;
  nix.gc = {
     automatic = true;
     dates = "weekly";
     options = "--delete-older-than 7d";
   };

  # Paquets non libres.
  nixpkgs.config.allowUnfree = true;
  
  # Mes applications.
  environment.systemPackages = with pkgs; [
   # Editeur/code  
	vscode
	bash-completion
	git
   # Theme/visuel
	plymouth
  adw-gtk3
  qogir-icon-theme
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
	vlc
   # Gnome extensions
	gnome.gnome-tweaks
	gnomeExtensions.blur-my-shell
	gnomeExtensions.spotify-tray
	gnomeExtensions.appindicator
	gnomeExtensions.dash-to-dock	
  ];
  
  # Installation de Steam.
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; 
  dedicatedServer.openFirewall = true; 
};
 
  # Nettoyage de Gnome.
  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [
    gnome.gnome-music gnome-tour gnome-photos gnome.gnome-weather 
    gnome.totem gnome.tali gnome.iagno gnome.hitori gnome.atomix gnome.simple-scan
    gnome.yelp gnome.gnome-maps gnome.gnome-clocks gnome-connections
    gnome.geary xterm gnome-user-docs gnome.gnome-calculator gnome.cheese epiphany
    gnome.gnome-packagekit packagekit system-config-printer gnome-tour
  ];

  # Nerdfonts.
  fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "FantasqueSansMono" ]; })
];
   
  system.stateVersion = "23.11"; 

}
