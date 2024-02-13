{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ./config/VM.nix
      ./config/AMD-pstate.nix
      ./config/Alias.nix      
      ./config/Nix-clean.nix
      ./config/Gnome-clean.nix
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
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.driSupport = true; 
  hardware.opengl.driSupport32Bit = true; 
  programs.corectrl.gpuOverclock.enable = true;
  environment.sessionVariables = {
  #If your cursor becomes invisible
  WLR_NO_HARDWARE_CURSORS = "1";
  #Hint electron apps to use wayland
  NIXOS_OZONE_WL = "1";
};

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
   
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
   corectrl
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
 
  # Nerdfonts.
  fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "FantasqueSansMono" ]; })
];
   
  system.stateVersion = "23.11"; 

}
