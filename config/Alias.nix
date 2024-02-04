{ config, pkgs, ... }:

{
    programs.bash.shellAliases = { 
    nixup = "sudo nixos-rebuild switch --upgrade";
    };

}