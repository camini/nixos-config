{ config, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [
  vesktop
  freecad
  celluloid
  thunderbird
  firefox
  mangohud
  goverlay
  btop  
  fastfetch
  obs-studio
  libreoffice-fresh
  
  ];

}


