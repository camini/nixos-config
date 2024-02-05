{ config, pkgs, ... }:

{
services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [
    gnome.gnome-music gnome-tour gnome-photos gnome.gnome-weather 
    gnome.totem gnome.tali gnome.iagno gnome.hitori gnome.atomix gnome.simple-scan
    gnome.yelp gnome.gnome-maps gnome.gnome-clocks gnome-connections
    gnome.geary xterm gnome-user-docs gnome.gnome-calculator gnome.cheese epiphany
    gnome.gnome-packagekit packagekit system-config-printer gnome-tour
  ];
}