{ lib, config, pkgs, ... }:

{
services.xserver = {
    enable = true;
    displayManager.gdm.enable   = true;
    desktopManager.gnome.enable = true;
  };

environment.systemPackages = with pkgs; [  
  gnome.gnome-tweaks
  gnome.eog
  gnomeExtensions.gsconnect
  gnomeExtensions.caffeine
  gnomeExtensions.dash-to-dock
  graphite-gtk-theme
  tela-circle-icon-theme
  gnomeExtensions.appindicator
  adw-gtk3  
  ];

services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [
    gnome.gnome-music gnome-tour gnome.gnome-weather 
    gnome.totem gnome.tali gnome.iagno gnome.hitori gnome.atomix gnome.simple-scan
    gnome.yelp gnome.gnome-maps gnome.gnome-clocks 
    gnome.geary xterm gnome-user-docs epiphany
    gnome.gnome-packagekit packagekit system-config-printer gnome-tour
  ];  

}

