{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # this is already done in configuration.nix
  #### Configure keymap in X11
  ###services.xserver.xkb = {
  ###  layout = "us";
  ###  variant = "";
  ###};
}
