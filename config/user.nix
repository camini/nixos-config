{ config, pkgs, ... }:

{
users.users.cammi = {
    isNormalUser = true;
    description = "cammi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #ici , les paquets uniquement pour l'user
    ];
  };

}
