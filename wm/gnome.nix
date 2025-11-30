{ config, inputs, lib, pkgs, ... }:

{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  #programs.gnome3.gnome-tweaks = enable;
  #environment.systemPackages.pkgs.gnome-tweaks = true;
  ##pkgs.programs.gnome-tweaks.enable = true;
  environment.systemPackages = [
    pkgs.gnome-tweaks
  ];
}
