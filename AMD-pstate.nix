{ config, pkgs, ... }:

{
  # Activation AMD P-state pour une meilleure gestion energetique du CPU
   boot.kernelParams = [ "amd_pstate=active" "mitigations=off" ];
}

