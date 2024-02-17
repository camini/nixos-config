{ config, pkgs, ... }:

{
    programs.bash.shellAliases = { 
    nixup = "sudo nixos-rebuild switch --upgrade";
    cleans = "sudo nix-store --gc";
    cleang = "sudo nix-collect-garbage -d";
    };

}