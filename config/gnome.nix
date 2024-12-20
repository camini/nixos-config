{ lib, config, pkgs, ... }:

{
services.xserver = {
    enable = true;
    displayManager.gdm.enable   = true;
    desktopManager.gnome.enable = true;
  };

environment.systemPackages = with pkgs; [  
  gnome-tweaks
  gnomeExtensions.gsconnect
  gnomeExtensions.caffeine
  gnomeExtensions.dash-to-dock
  tela-circle-icon-theme
  gnomeExtensions.appindicator
  adw-gtk3  
  ];

services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [
    gnome-music gnome-tour gnome-weather 
    tali iagno hitori atomix simple-scan
    yelp gnome-maps gnome-clocks 
    geary xterm gnome-user-docs epiphany
    gnome-packagekit packagekit system-config-printer gnome-tour
  ];  

programs.dconf.profiles.user = {
        databases = [{
            settings = {
                # Gnome
                "org/gnome/desktop/wm/preferences" = {
                    button-layout = "appmenu:minimize,maximize,close";
                };
                "org/gnome/desktop/interface" = {
                    enable-hot-corners = true;
                    gtk-theme = "adw-gtk3";
                    icon-theme = "Tela-circle";
                };
                "org/gnome/mutter" = {
                    check-alive-timeout = lib.gvariant.mkUint32 30000;
                    dynamic-workspaces = true;
                    edge-tiling = true;
                };
                "org/gnome/desktop/wm/preferences" = {
                    theme = "adw-gtk3";
                };

                # Extensions
                "org/gnome/shell" = {
                    enabled-extensions = [
                        "caffeine@patapon.info"
                        "appindicatorsupport@rgcjonas.gmail.com"
                        "dash-to-dock@micxgx.gmail.com"
                    ];     
                };
              };
           }];
        };
}

