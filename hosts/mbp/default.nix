{ config, inputs, lib, pkgs, ... }:

{
  imports =
    [
  #     ./hardware-configuration.nix
  #     ../../networkmanager.nix
  #     ../../wm/gnome.nix
  #     #../../wm/hyprland.nix
    ];
    
  #!TODO
  # services.openvpn.servers = {
  #   homeVPN = { config = '' config /home/dilly/Downloads/homeVPN.conf ''; };
  # };

  programs.fish.enable = true;

  # runs fish by default unless in recovery mode since fish isn't POSIX compliant
  programs.zsh = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     "text/html" = "librewolf";
  #     "x-scheme-handler/http" = "librewolf";
  #     "x-scheme-handler/https" = "librewolf";
  #     "x-scheme-handler/about" = "librewolf";
  #     "x-scheme-handler/unknown" = "librewolf";
  #   };
  # };

  #programs.starship.enable = true;

  environment.variables.EDITOR = "nvim";
  # programs.neovim.configure = import ./init.lua;

  nixpkgs.config.allowUnfree = true;
  # PACKAGES
  environment.systemPackages = with pkgs; [
    thunderbird
    librewolf
    #nerd-fonts.iosevka
    localsend
    zellij
    fishPlugins.done
    #fishPlugins.fzf-fish
    fzf
    zathura
    gcc
    #docker
    #xquartz #broken?
    #darwin.xcode
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  system.defaults.NSGlobalDomain.InitialKeyRepeat = 100;
  system.defaults.NSGlobalDomain.KeyRepeat = 100;

  # virtualisation.docker.enable = true;


  # programs.ssh.startAgent = true;
  services.openssh.enable = true;

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

  # sops = {
  #   defaultSopsFile = ../../secrets/secrets.yaml;
  #   defaultSopsFormat = "yaml";
  #   age.keyFile = "/home/dilly/.config/sops/age/keys.txt";
  #   age.generateKey = true;
  #   secrets = {
  #     "openssh/github-t480" = {
  #       sopsFile = ../../secrets/secrets.yaml;
  #       # owner = "root";
  #       # group = "root";
  #       # mode = "0400";
  #       # neededForUsers = true;
  #     };
  #     "hostId" = {
  #       sopsFile = ../../secrets/secrets.yaml;
  #       owner = "root";
  #       group = "root";
  #       mode = "0400";
  #       neededForUsers = true;
  #     };
  #   };
  # };

  users.users."dilly".openssh.authorizedKeys.keys = [
    #/run/secrets/openssh/github-t480
    #config.sops.secrets."openssh/github-t480".path
    "$(cat /run/secrets-mbp/openssh/github-mpb)"
  ];
  # sops.secrets."openssh/github-t480" = {
  #   restartUnits = [ "sshd.service" ];
  #   sopsFiles = ../../secrets/secrets.yaml;
  # };

  # users.users."dilly".openssh.authorizedKeys.keyFiles = [
  #   config.sops.secrets."openssh/github-t480".path
  # ];

  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true;
  #   dedicatedServer.openFirewall = true;
  #   localNetworkGameTransfers.openFirewall = true;
  # };

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    nerd-fonts.comic-shanns-mono
  ];
}
