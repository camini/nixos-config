{ config, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [
  github-desktop
  davinci-resolve
  freecad
  prusa-slicer
  dconf-editor
  vesktop
  thunderbird
  firefox
  mangohud
  goverlay
  btop  
  fastfetch
  obs-studio
  libreoffice-fresh
  nvtopPackages.amd  
  ];

}


