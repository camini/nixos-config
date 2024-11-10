{ config, pkgs, ... }:

{
   programs.bash.promptInit = "PS1='\\[\\033[01;32m\\]\\u@\\h\\[\\033[00m\\] \\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\n\\$ '";
 
   programs.bash.shellAliases = { 
    nixup = "sudo nixos-rebuild switch --upgrade";
    cleans = "sudo nix-store --gc";
    cleang = "sudo nix-collect-garbage -d";
    };

}
