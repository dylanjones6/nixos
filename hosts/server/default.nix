{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
    
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-server"; # Define your hostname.

  #services.xserver.xkb = {
  #  layout = "us";
  #  variant = "";
  #};

  time.timeZone = "America/Denver";

  #environment.etc.crypttab = {
  #  mode = "0600";
  #  text = ''
  #    # <volume-name> <encrypted-device> [key-file] [options]
  #    cryptstorage UUID=10328293-36ca-4fb7-8ff2-3888e6988a5c /root/mykeyfile.key
  #  '';
  #};

  users.users.dilly = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDhrmdbqS5Irbo0RnllqbkPIULF7AQGcBIN6xkZm7Cd9 dilly@nixos-t480"
    ];
  };
  #programs.librewolf.enable = false;
  environment.systemPackages = with pkgs; [
    hugo
  ];
  
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 1313 ];
}
## Edit this configuration file to define what should be installed on
## your system.  Help is available in the configuration.nix(5) man page
## and in the NixOS manual (accessible by running ‘nixos-help’).
#
#{ config, pkgs, ... }:
#
#{
#  imports =
#    [ # Include the results of the hardware scan.
#      ./hardware-configuration.nix
#    ];
#
#  # Bootloader.
#  boot.loader.systemd-boot.enable = true;
#  boot.loader.efi.canTouchEfiVariables = true;
#
#  
#  environment.etc.crypttab = {
#    mode = "0600";
#    text = ''
#      # <volume-name> <encrypted-device> [key-file] [options]
#      cryptstorage UUID=99b554b4-1f6a-4e4d-a97a-a50335250057 /root/mykeyfile.key
#    '';
#  };
#  
#
#  networking.hostName = "nixos-server"; # Define your hostname.
#  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
#
#  # Configure network proxy if necessary
#  # networking.proxy.default = "http://user:password@proxy:port/";
#  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
#
#  # Enable networking
#  networking.networkmanager.enable = true;
#
#  # Set your time zone.
#  time.timeZone = "America/Denver";
#
#  # Select internationalisation properties.
#  i18n.defaultLocale = "en_US.UTF-8";
#
#  i18n.extraLocaleSettings = {
#    LC_ADDRESS = "en_US.UTF-8";
#    LC_IDENTIFICATION = "en_US.UTF-8";
#    LC_MEASUREMENT = "en_US.UTF-8";
#    LC_MONETARY = "en_US.UTF-8";
#    LC_NAME = "en_US.UTF-8";
#    LC_NUMERIC = "en_US.UTF-8";
#    LC_PAPER = "en_US.UTF-8";
#    LC_TELEPHONE = "en_US.UTF-8";
#    LC_TIME = "en_US.UTF-8";
#  };
#
#  # Configure keymap in X11
#  services.xserver.xkb = {
#    layout = "us";
#    variant = "";
#  };
#
#  # Define a user account. Don't forget to set a password with ‘passwd’.
#  users.users.dilly = {
#    isNormalUser = true;
#    description = "dylan";
#    extraGroups = [ "networkmanager" "wheel" ];
#    openssh.authorizedKeys.keys = [
#      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDhrmdbqS5Irbo0RnllqbkPIULF7AQGcBIN6xkZm7Cd9 dilly@nixos-t480"
#    ];
#    packages = with pkgs; [];
#  };
#
#  # Allow unfree packages
#  nixpkgs.config.allowUnfree = true;
#
#  # List packages installed in system profile. To search, run:
#  # $ nix search wget
#  environment.systemPackages = with pkgs; [
#    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
#    wget
#    neofetch
#    tmux
#    mdadm
#    git
#    tree
#  ];
#
#  services.openssh = {
#    enable = true;
#    settings = {
#      PasswordAuthentication = true;
#      PermitRootLogin = "no";
#    };
#  };
#
#  # Some programs need SUID wrappers, can be configured further or are
#  # started in user sessions.
#  # programs.mtr.enable = true;
#  # programs.gnupg.agent = {
#  #   enable = true;
#  #   enableSSHSupport = true;
#  # };
#
#  # List services that you want to enable:
#
#  programs.mosh.enable = true;
#
#  # Enable the OpenSSH daemon.
#  # services.openssh.enable = true;
#
#  # Open ports in the firewall.
#  networking.firewall.allowedTCPPorts = [ 22 ];
#  networking.firewall.allowedUDPPorts = [ 22 ];
#  # Or disable the firewall altogether.
#  networking.firewall.enable = true;
#
#  # This value determines the NixOS release from which the default
#  # settings for stateful data, like file locations and database versions
#  # on your system were taken. It‘s perfectly fine and recommended to leave
#  # this value at the release version of the first install of this system.
#  # Before changing this value read the documentation for this option
#  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
#  system.stateVersion = "25.05"; # Did you read the comment?
#
#}
