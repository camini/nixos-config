# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./config/steam.nix
      ./config/locale.nix
      ./config/gnome.nix
      ./config/alias.nix
      ./config/nix-clean.nix
      ./config/vm.nix
      ./config/hardware.nix
      ./config/user.nix
      ./config/program.nix
      ./config/ai.nix
   ];
   hardware.amdgpu.opencl.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
