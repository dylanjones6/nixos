{ config, lib, pkgs, inputs, ... }:
{
  # # Enable networking
  # networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  #services.openvpn.servers = {
  #  homeVPN    = { config = '' config /root/nixos/openvpn/homeVPN.conf ''; };
  #};

  #virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dilly = {
    isNormalUser = true;
    description = "dylan";
    #extraGroups = [ "networkmanager" "wheel" ];
    extraGroups = [ "wheel" "network" ];
  };

  # Allow unfree packages :(
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    tree
    tmux
    cbonsai
    mosh
    direnv
    mdadm
    psmisc
    sops
    age
  ];

  services.openssh.enable = true;

  environment.shellAliases = {
    #"nixup" = "sudo nixos-rebuild switch && git -C $HOME/.config/nixos add . && git -C $HOME/.config/nixos commit  && git -C $HOME/.config/nixos push origin main";
    "nixup" = "sudo nixos-rebuild switch";
    "connect-vpn" = "sudo systemctl start openvpn-homeVPN.service";
    "disconnect-vpn" = "sudo systemctl stop openvpn-homeVPN.service";
  };

  # Enable the uinput module
  boot.kernelModules = [ "uinput" ];

  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = { };

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          # Replace the paths below with the appropriate device paths for your setup.
          # Use `ls /dev/input/by-path/` to find your keyboard devices.
          ##"/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          ##"/dev/input/by-path/pci-0000:00:14.0-usb-0:3:1.0-event-kbd"
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          "/dev/input/by-path/platform-thinkpad_acpi-event"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc caps)
          (deflayer default esc)
        '';
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
