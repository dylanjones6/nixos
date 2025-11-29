{ config, inputs, lib, pkgs, agenix, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../wm/gnome.nix
      #../../wm/hyprland.nix
    ];
    
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # boot.initrd.luks.devices."luks-238c3396-4da1-4067-8aa1-a7bb4023b18a".device = "/dev/disk/by-uuid/238c3396-4da1-4067-8aa1-a7bb4023b18a";
  networking.hostName = "nixos-t480";
  networking.hostId = "b7b78d22";

  #!TODO get this working, something to do with it working at build time?
  #networking.hostId = "$(cat /run/secrets/hostId)";
  #networking.hostId = config.sops.secrets."hostId".path;

  time.timeZone = "America/Denver";
  
  #!TODO
  # services.openvpn.servers = {
  #   homeVPN = { config = '' config /root/nixos/openvpn/homeVPN.conf ''; };
  # };

  users.users.dilly = {
    shell = pkgs.nushell;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # other shit goes here but i hand typed this so idc look at commented out configuration.nix
  };

  #programs.firefox.enable = true;

  #programs.thunderbird.enable = true;

  #programs.librewolf.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    thunderbird
    #librewolf
    kitty
    #nerd-fonts.iosevka
    wofi
    waybar
    eww
    networkmanager_dmenu
    hyprpaper
    #gnome-font-viewer
    font-manager
    fontpreview
    localsend
    nautilus
    zellij
  ];

  # programs.nushell = {
  #   enable = true;
  #   extraConfig = ''
  #       $env.config.buffer_editor = "nvim"
  #   '';
  # };

  users.defaultUserShell = pkgs.nushell;

  # programs.ssh.startAgent = true;

  # age.secrets.github-t480= {
  #   file = ../../../secrets/github-t480.age;
  # };
  

  # sops.defaultSopsFile = ../../secrets/secrets.yaml;
  # sops.defaultSopsFormat = "yaml";

  # sops.age.keyFile = "/home/dilly/.config/sops/age/keys.txt";
  # sops.age.generateKey = true;
  # #sops.secrets."openssh/github-t480" = {
  # #  owner = config.users.users.dilly.name;
  # #};

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/dilly/.config/sops/age/keys.txt";
    age.generateKey = true;
    secrets = {
      "openssh/github-t480" = {
        sopsFile = ../../secrets/secrets.yaml;
	# owner = "root";
	# group = "root";
	# mode = "0400";
	# neededForUsers = true;
      };
      "hostId" = {
        sopsFile = ../../secrets/secrets.yaml;
	owner = "root";
	group = "root";
	mode = "0400";
	neededForUsers = true;
      };
    };
  };

  #!TODO
  users.users."dilly".openssh.authorizedKeys.keys = [
    #/run/secrets/openssh/github-t480
    #config.sops.secrets."openssh/github-t480".path
    "$(cat /run/secrets/openssh/github-t480)"
  ];
  # sops.secrets."openssh/github-t480" = {
  #   restartUnits = [ "sshd.service" ];
  #   sopsFiles = ../../secrets/secrets.yaml;
  # };

  # users.users."dilly".openssh.authorizedKeys.keyFiles = [
  #   config.sops.secrets."openssh/github-t480".path
  # ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    nerd-fonts.comic-shanns-mono
  ];

  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];

}
